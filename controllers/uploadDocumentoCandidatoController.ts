import { Request, Response, NextFunction } from "express";
import multer from "multer";
import path from "path";
import fs from "fs";
import DocumentoCandidato from "../models/documentos_candidato";

// Configuración de almacenamiento
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    // Validación mejorada del RUT
    const rut = req.body.rut;

    if (!rut) {
      return cb(new Error("RUT del candidato es requerido"), "");
    }

    // Sanitizar RUT y verificar formato
    const cleanRUT = rut.replace(/[^0-9kK-]/g, "");
    if (!/^\d{1,8}-[\dkK]$/.test(cleanRUT)) {
      return cb(new Error("Formato de RUT inválido"), "");
    }

    const uploadPath = path.join(__dirname, "../uploads", cleanRUT);

    // Crear carpeta si no existe
    if (!fs.existsSync(uploadPath)) {
      fs.mkdirSync(uploadPath, { recursive: true });
    }

    cb(null, uploadPath);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = `${Date.now()}-${Math.round(Math.random() * 1e9)}`;
    const ext = path.extname(file.originalname).toLowerCase();
    cb(null, `file-${uniqueSuffix}${ext}`);
  },
});

// Filtro de archivos mejorado
const fileFilter = (
  req: Request,
  file: Express.Multer.File,
  cb: multer.FileFilterCallback
) => {
  const allowedExts = [".pdf", ".doc", ".docx", ".jpg", ".jpeg", ".png"];
  const ext = path.extname(file.originalname).toLowerCase();

  if (allowedExts.includes(ext)) {
    cb(null, true);
  } else {
    cb(new Error(`Tipo de archivo no permitido: ${ext}`));
  }
};

// Middleware Multer exportado con manejo de errores
export const uploadSingle = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const multerMiddleware = multer({
    storage,
    fileFilter,
    limits: { fileSize: 2 * 1024 * 1024 },
  }).single("file");

  multerMiddleware(req, res, (err: any) => {
    if (err) {
      // Manejar diferentes tipos de errores de Multer
      let status = 400;
      let message = err.message;

      if (err.code === "LIMIT_FILE_SIZE") {
        message = "El archivo excede el tamaño máximo de 2MB";
        status = 413;
      }

      return res.status(status).json({ error: message });
    }
    next();
  });
};

// Controlador mejorado con validaciones
export const uploadCandidatoDocumento = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  // Añade ": Promise<void>" aquí
  console.log(req.body);
  /*   try {
    const { candidato_id, documento_id, rut } = req.body;

    if (!rut || !candidato_id || !documento_id) {
      res.status(400).json({
        error:
          "Todos los campos son requeridos: rut, candidato_id, documento_id",
      });
      return; // Usa return en lugar de devolver res
    }

    if (isNaN(Number(candidato_id)) || isNaN(Number(documento_id))) {
      res.status(400).json({
        error: "candidato_id y documento_id deben ser números válidos",
      });
      return;
    }

    if (!req.file) {
      res.status(400).json({ error: "Archivo es requerido" });
      return;
    }

    // ... resto de la lógica ...

    const cleanRUT = rut.replace(/[^0-9kK-]/g, "");
    const ruta = `/uploads/${cleanRUT}/${req.file.filename}`;

    const nuevo = await DocumentoCandidato.create({
      candidato_id: Number(candidato_id),
      documento_id: Number(documento_id),
      ruta,
    });

    res.status(201).json(nuevo);
  } catch (error: any) {
    if (error.name === "SequelizeForeignKeyConstraintError") {
      res.status(400).json({
        error: "El candidato o documento especificado no existe",
      });
    } else {
      console.error("Error en uploadCandidatoDocumento:", error);
      res.status(500).json({ error: "Error interno del servidor" });
    }
  } */
};
