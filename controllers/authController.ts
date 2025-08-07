import { Request, Response } from "express";
import Usuario from "../models/usuario";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const jwtSecret = process.env.JWT_SECRET || "secret8key_par4desarrollo";

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
      { expiresIn: "8h" }
    );

    // Excluir password en la respuesta
    const userResponse = {
      id: user.id,
      usuario: user.usuario,
      rol: user.rol,
      estado: user.estado,
      created_at: user.created_at,
    };

    res.json({ token, user: userResponse });
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
