import { Request, Response } from "express";
import Usuario from "../models/usuario";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import Candidato from "../models/candidato";
import db from "../BD/connection";
import { v4 as uuidv4 } from "uuid";
import Comuna from "../models/comuna";
import Region from "../models/region";
import Cargo from "../models/cargo";

const jwtSecret = process.env.JWT_SECRET || "secret8key_par4desarrollo";
export const saltRounds = 10;

async function generarUIDUnico(): Promise<string> {
  let uid: string = "";
  let existe: any = true;

  while (existe) {
    uid = uuidv4();
    existe = await Usuario.findOne({ where: { uid } });
  }

  return uid;
}

declare global {
  namespace Express {
    interface Request {
      user?: IUser;
    }
  }
}

export interface IUser {
  id?: number;
  usuario: string;
  password: string;
  estado: boolean;
  rol: string;
  created_at?: Date;
}

export interface ILogin {
  usuario: string;
  password: string;
}

export interface IRegisterCandidate {
  usuario: string;
  password: string;
  nombre: string;
  email?: string;
}

export const login = async (req: Request, res: Response) => {
  const { usuario, password }: ILogin = req.body;

  try {
    // Buscar usuario
    const user: any = await Usuario.findOne({ where: { usuario } });

    if (!user) {
      res.status(404).json({ message: "Usuario no encontrado" });
      return;
    }

    // Verificar estado
    if (!user.estado) {
      res.status(401).json({ message: "Usuario desactivado" });
      return;
    }

    // Verificar contraseña
    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      res.status(400).json({ message: "Contraseña incorrecta" });
      return;
    }

    // Crear token JWT
    const token = jwt.sign(
      { id: user.id, usuario: user.usuario, rol: user.rol },
      jwtSecret,
      { expiresIn: "2h" }
    );

    const candidato = await Candidato.findOne({
      where: { usuario_id: user.id },
      include: [
        {
          model: Comuna,
          include: [Region],
        },
        {
          model: Cargo,
          attributes: ["id", "nombre"], // Atributos específicos de Cargo
          through: { attributes: [] },
          as: "cargos",
        },
      ],
    });

    console.log("candidato", candidato);

    // Excluir password en la respuesta
    const userResponse = {
      id: user.uid,
      rol: user.rol,
      estado: user.estado,
      token,
    };

    res.json({
      user: userResponse,
      candidato,
    });
    return;
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error en el servidor" });
    return;
  }
};

export const getProfile = async (req: Request, res: Response) => {
  // El usuario ya está disponible en req.user gracias al middleware
  const user = req.user as IUser;

  // Excluir password en la respuesta
  const userResponse = {
    id: user.id,
    usuario: user.usuario,
    rol: user.rol,
    estado: user.estado,
    created_at: user.created_at,
  };

  res.json(userResponse);
  return;
};

export const registerCandidate = async (req: Request, res: Response) => {
  const { usuario, password, nombre, email }: IRegisterCandidate = req.body;

  try {
    // Verificar si el usuario ya existe
    const existingUser = await Usuario.findOne({ where: { usuario } });
    if (existingUser) {
      res.status(400).json({ message: "El nombre de usuario ya está en uso" });
      return;
    }

    // Verificar si el rut ya está registrado
    const existingCandidate = await Candidato.findOne({
      where: { rut: usuario },
    });
    if (existingCandidate) {
      res
        .status(400)
        .json({ message: "El correo electrónico ya está registrado" });
      return;
    }

    // Crear transacción para asegurar la integridad de los datos
    const transaction = await db.transaction();

    try {
      // Crear el usuario
      const hashedPassword = await bcrypt.hash(password, saltRounds);
      const uid = await generarUIDUnico();
      const newUser: any = await Usuario.create(
        {
          usuario,
          password: hashedPassword,
          uid,
        },
        { transaction }
      );

      // Crear el candidato asociado
      const newCandidate: any = await Candidato.create(
        {
          rut: usuario,
          nombre_completo: nombre,
          correo: email,
          usuario_id: newUser.id,
        },
        { transaction }
      );

      // Confirmar la transacción
      await transaction.commit();
      console.log("newUser", newUser);
      const token = jwt.sign(
        { id: newUser.id, usuario: usuario, rol: newUser.rol },
        jwtSecret,
        { expiresIn: "2h" }
      );
      console.log("token", token);

      // Excluir password en la respuesta
      const userResponse = {
        id: newUser.id,
        rol: newUser.rol,
        estado: newUser.estado,
        token,
      };
      console.log("userResponse", userResponse);
      console.log("newCandidate", newCandidate);

      res.status(201).json({
        message: "Registro exitoso",
        user: userResponse,
        candidato: newCandidate,
      });
      return;
    } catch (error) {
      // Revertir la transacción en caso de error
      await transaction.rollback();
      throw error;
    }
  } catch (error) {
    console.error("Error en registro:", error);
    res
      .status(500)
      .json({ message: "Error en el servidor durante el registro" });
    return;
  }
};
