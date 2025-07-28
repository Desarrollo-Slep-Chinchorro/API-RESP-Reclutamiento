import { Request, Response, NextFunction } from "express";
import multer from "multer";
import path from "path";
import DocumentoCandidato from "../models/documentos_candidato";

// Multer storage configuration
const storage = multer.diskStorage({
  destination: (_req, _file, cb) => {
    cb(null, path.join(__dirname, "../uploads"));
  },
  filename: (_req, file, cb) => {
    const uniqueSuffix = `${Date.now()}-${Math.round(Math.random() * 1e9)}`;
    const ext = path.extname(file.originalname).toLowerCase();
    cb(null, `file-${uniqueSuffix}${ext}`);
  },
});

// File filter to allow only specific extensions
const fileFilter = (
  _req: Request,
  file: Express.Multer.File,
  cb: multer.FileFilterCallback
) => {
  const allowedExts = [".pdf", ".doc", ".docx", ".jpg", ".jpeg", ".png"];
  const ext = path.extname(file.originalname).toLowerCase();
  if (allowedExts.includes(ext)) cb(null, true);
  else cb(new Error("Tipo de archivo no permitido"));
};

// Multer middleware exports
export const uploadSingle = multer({
  storage,
  fileFilter,
  limits: { fileSize: 2 * 1024 * 1024 }, // 2 MB
}).single("file");

// Async handler to capture errors
export const asyncHandler =
  (fn: (req: Request, res: Response, next: NextFunction) => Promise<any>) =>
  (req: Request, res: Response, next: NextFunction) => {
    fn(req, res, next).catch(next);
  };

// Controller to handle upload and DB record creation
export const uploadCandidatoDocumento = asyncHandler(
  async (req: Request, res: Response) => {
    const { candidato_id, documento_id } = req.body;
    if (!req.file) {
      res.status(400).json({ message: "Archivo es requerido" });
      return;
    }
    // Ruta pública del archivo
    const ruta = `/uploads/${req.file.filename}`;
    // Crear registro en BD
    const nuevo = await DocumentoCandidato.create({
      candidato_id,
      documento_id,
      ruta,
    });
    res.status(201).json(nuevo);
    return;
  }
);
