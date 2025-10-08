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
import axios from "axios";
import Jornada from "../models/jornada";
import Ciudad from "../models/ciudad";
import Modalidades from "../models/modalidad";
import {
  generarTokenRecuperacion,
  enviarCorreoRecuperacion,
} from "../utils/validaciones";
import { log } from "console";

const jwtSecret = process.env.JWT_SECRET || "secret8key_par4desarrollo";
export const saltRounds = 10;

export const validarToken = (req: Request, res: Response) => {
  const { token } = req.body;
  try {
    jwt.verify(token, process.env.JWT_SECRET!);
    res.json({ valido: true });
  } catch {
    res.status(401).json({ message: "Token inválido o expirado" });
  }
};

async function generarUIDUnico(): Promise<string> {
  let uid: string = "";
  let existe: any = true;

  while (existe) {
    uid = uuidv4();
    existe = await Usuario.findOne({ where: { uid } });
  }

  return uid;
}

async function validarRecaptcha(token: string): Promise<boolean> {
  const secretKey = process.env.RECAPTCHA_SECRET_KEY; // asegúrate de tener esto en tu .env

  try {
    const response = await axios.post(
      "https://www.google.com/recaptcha/api/siteverify",
      null,
      {
        params: {
          secret: secretKey,
          response: token,
        },
      }
    );

    const { success, score, action } = response.data;

    return success && score >= 0.5 && action === "login";
  } catch (error) {
    console.error("Error al validar reCAPTCHA:", error);
    return false;
  }
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
  recaptcha: string;
}

export const login = async (req: Request, res: Response) => {
  const { usuario, password, recaptcha }: ILogin & { recaptcha: string } =
    req.body;

  // Validar reCAPTCHA antes de continuar
  const esHumano = await validarRecaptcha(recaptcha);
  if (!esHumano) {
    res.status(403).json({ message: "Verificación reCAPTCHA fallida" });
    return;
  }

  try {
    const user: any = await Usuario.findOne({ where: { usuario } });

    if (!user) {
      res.status(404).json({ message: "Usuario no encontrado" });
      return;
    }

    if (!user.estado) {
      res.status(401).json({ message: "Usuario desactivado" });
      return;
    }

    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      res.status(400).json({ message: "Contraseña incorrecta" });
      return;
    }

    const token = jwt.sign(
      { id: user.id, usuario: user.usuario, rol: user.rol },
      jwtSecret,
      { expiresIn: "4h" }
    );

    const candidato = await Candidato.findOne({
      where: { usuario_id: user.id },
      include: [
        { model: Comuna, include: [Region] },
        {
          model: Cargo,
          attributes: ["id", "nombre"],
          through: { attributes: [] },
          as: "cargos",
        },
        {
          model: Jornada,
          attributes: ["id", "nombre"],
          through: { attributes: [] },
          as: "jornadas",
        },
        {
          model: Ciudad,
          attributes: ["id", "nombre"],
          through: { attributes: [] },
          as: "ciudades",
        },
        {
          model: Modalidades,
          attributes: ["id", "nombre"],
          through: { attributes: [] },
          as: "modalidades_horarias",
        },
      ],
    });

    const userResponse = {
      id: user.uid,
      rol: user.rol,
      estado: user.estado,
      token,
    };

    console.log("Candidato logged in:", candidato);

    res.json({ user: userResponse, candidato });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error en el servidor" });
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
  const { usuario, password, nombre, email, recaptcha }: IRegisterCandidate =
    req.body;

  // Validar reCAPTCHA antes de continuar
  const esHumano = await validarRecaptcha(recaptcha);
  if (!esHumano) {
    res.status(403).json({ message: "Verificación reCAPTCHA fallida" });
    return;
  }

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

export const recuperarClave = async (req: Request, res: Response) => {
  const { rut } = req.body;
  console.log("RUT recibido:", rut);

  if (!rut || typeof rut !== "string") {
    console.log("RUT inválido recibido:", rut);

    res.status(400).json({ message: "RUT inválido" });
    return;
  }

  try {
    const usuario: any = await Usuario.findOne({
      where: { usuario: rut },
    });
    if (!usuario.id) {
      res.status(404).json({ message: "Usuario no encontrado" });
      return;
    }
    const candidato = await Candidato.findOne({
      where: { usuario_id: usuario.id },
    });

    if (!candidato || !candidato.correo) {
      res
        .status(404)
        .json({ message: "No se encontró un correo asociado a ese RUT" });
      return;
    }

    const token = generarTokenRecuperacion(usuario.id);
    console.log("Token generado:", token);

    await enviarCorreoRecuperacion(candidato.correo, token);

    res.json({ message: "Correo de recuperación enviado correctamente" });
  } catch (error) {
    console.error(" Error en recuperación:", error);
    res.status(500).json({ message: "Error al procesar la solicitud", error });
  }
};

export const restablecerClave = async (req: Request, res: Response) => {
  const { token, nuevaClave } = req.body;

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET!) as {
      usuarioId: number;
    };

    const usuario: any = await Usuario.findByPk(payload.usuarioId);

    if (!usuario) {
      res.status(404).json({ message: "usuario no encontrado" });
      return;
    }

    usuario.password = await bcrypt.hash(nuevaClave, 10);
    await usuario.save();

    res.json({ message: "Contraseña actualizada correctamente" });
  } catch {
    res.status(401).json({ message: "Token inválido o expirado" });
  }
};
