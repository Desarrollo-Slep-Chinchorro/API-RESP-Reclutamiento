import { Request, Response, NextFunction } from "express";
import jwt, { SignOptions, JwtPayload } from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

// Extend Express Request interface to include `user`
declare global {
  namespace Express {
    interface Request {
      user?: JwtPayload;
    }
  }
}

const JWT_SECRET = process.env.JWT_SECRET as string;
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN as string; // e.g. "1h"

// Helper to sign a JWT for a given payload
export const generateToken = (payload: object): string => {
  const options: SignOptions = {
    expiresIn: JWT_EXPIRES_IN as unknown as SignOptions["expiresIn"],
  };
  return jwt.sign(payload, JWT_SECRET, options);
};

// Middleware to verify JWT and attach decoded payload to req.user
export const authenticateToken = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && (authHeader as string).split(" ")[1];
  if (!token) {
    res.status(401).json({ message: "Token no proporcionado" });
    return;
  }
  jwt.verify(token, JWT_SECRET, (err, decoded) => {
    if (err) {
      res.status(403).json({ message: "Token inválido" });
      return;
    }
    // Attach user payload to request
    req.user = decoded as JwtPayload;
    next();
  });
};

// Middleware to check specific roles (example)
export const authorizeRoles = (...roles: string[]) => {
  return (req: Request, res: Response, next: NextFunction) => {
    const user = req.user;
    if (!user || !roles.includes((user.role as string) || "")) {
      res
        .status(403)
        .json({ message: "No tienes permisos para acceder a este recurso" });
      return;
    }
    next();
  };
};

// Installation:
// npm install jsonwebtoken dotenv
// npm install -D @types/jsonwebtoken @types/dotenv
