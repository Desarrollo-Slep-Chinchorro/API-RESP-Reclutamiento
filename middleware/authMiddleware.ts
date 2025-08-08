import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import { IUser } from "../controllers/authController";

const jwtSecret = process.env.JWT_SECRET || "secret8key_par4desarrollo";

export const verifyToken = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const token = req.headers["authorization"]?.split(" ")[1];

  if (!token) {
    res.status(403).json({ message: "Token no proporcionado" });
    return;
  }

  try {
    const decoded = jwt.verify(token, jwtSecret) as IUser;
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({ message: "Token inválido o expirado" });
    return;
  }
};

export const checkRole = (roles: string[]) => {
  return (req: Request, res: Response, next: NextFunction) => {
    const user = req.user as IUser;

    if (!roles.includes(user.rol)) {
      res.status(403).json({ message: "No tienes permisos para esta acción" });
      return;
    }

    next();
  };
};
