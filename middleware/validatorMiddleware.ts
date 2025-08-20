import Joi, { Schema } from "joi";
import multer from "multer";
import CryptoJS from "crypto-js";
import baseX from "base-x";

// Reusable parameter schema for `:id`
export const paramIdSchema: Schema = Joi.object({
  id: Joi.number().integer().positive().required(),
});

// Candidate body schema
export const candidatoBodySchema: Schema = Joi.object({
  rut: Joi.string()
    .pattern(/^\d{7,8}-[\dkK]$/)
    .required(),
  nombre_completo: Joi.string().max(100).required(),
  titulo_profesional_id: Joi.number().integer().positive().required(),
  telefono: Joi.string()
    .pattern(/^\+?\d{8,12}$/)
    .required(),
  correo: Joi.string().email().required(),
  estado_candidato_id: Joi.number().integer().positive().required(),
  nacionalidad_id: Joi.number().integer().positive().required(),
  estado_civil_id: Joi.number().integer().positive().required(),
  direccion: Joi.string().max(255).required(),
  comuna_id: Joi.number().integer().positive().required(),
});

// DocumentoCandidato upload schema
export const documentoCandidatoUploadSchema: Schema = Joi.object({
  candidato_id: Joi.number().integer().positive().required(),
  documento_id: Joi.number().integer().positive().required(),
});

// Export helper to validate body in routes
import { Request, Response, NextFunction } from "express";
import { log } from "console";

export const validateBody =
  (schema: Schema) => (req: Request, res: Response, next: NextFunction) => {
    const { error } = schema.validate(req.body);
    if (error) {
      res.status(422).json({ errors: error.details.map((d) => d.message) });
      return;
    }
    next();
  };

// Export helper to validate params in routes
export const validateParams =
  (schema: Schema) => (req: Request, res: Response, next: NextFunction) => {
    const { error } = schema.validate(req.params);
    if (error) {
      res.status(422).json({ errors: error.details.map((d) => d.message) });
      return;
    }
    next();
  };

export const uploadMemory = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 2 * 1024 * 1024 }, // 2MB
  fileFilter: (req, file, cb) => {
    const allowedExts = [".pdf", ".doc", ".docx", ".jpg", ".jpeg", ".png"];
    const ext = file.originalname.toLowerCase().match(/\.\w+$/)?.[0] || "";
    if (allowedExts.includes(ext)) cb(null, true);
    else cb(new Error(`Tipo de archivo no permitido: ${ext}`));
  },
}).single("file");

export function decryptId(encoded: string): string {
  const BASE62 =
    "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  const base62 = baseX(BASE62);
  const secretKey = process.env.ID_ENCRYPT_KEY || "cL4v3-superS3cret4";
  const bytes = base62.decode(encoded);
  const encrypted = Buffer.from(bytes).toString("utf8");
  const decrypted = CryptoJS.AES.decrypt(encrypted, secretKey);
  return decrypted.toString(CryptoJS.enc.Utf8);
}
