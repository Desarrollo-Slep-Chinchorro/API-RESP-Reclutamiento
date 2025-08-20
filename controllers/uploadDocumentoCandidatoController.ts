// controllers/documentos.ts
import { Request, Response, NextFunction } from "express";
import path from "path";
import fs from "fs";
import DocumentoCandidato from "../models/documentos_candidato";
import { decryptId } from "../middleware/validatorMiddleware";

export const viewFiles = async (req: Request, res: Response) => {
  const id = decryptId(req.params.id);
  if (!id) {
    res.status(400).json({ error: "ID inválido" });
    return;
  }
  try {
    const doc: any = await DocumentoCandidato.findByPk(id);
    if (!doc || !doc.ruta) {
      res.status(404).send("Archivo no encontrado");
      return;
    }

    const rutaAbsoluta = path.join(__dirname, "..", doc.ruta);
    if (!fs.existsSync(rutaAbsoluta)) {
      res.status(404).send("Archivo no existe en disco");
      return;
    }

    res.sendFile(rutaAbsoluta);
  } catch (error) {
    console.error("Error al servir archivo:", error);
    res.status(500).send("Error interno");
  }
};

export const uploadCandidatoDocumento = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const { rut, candidato_id, documento_id, nombre_para_mostrar } = req.body;
    const archivo = req.file;

    // Validaciones
    if (!rut || !candidato_id || !documento_id) {
      res.status(400).json({ error: "Faltan campos requeridos" });
      return;
    }

    if (!archivo) {
      res.status(400).json({ error: "Archivo no recibido" });
      return;
    }

    if (isNaN(Number(candidato_id)) || isNaN(Number(documento_id))) {
      res.status(400).json({ error: "ID inválido de candidato o documento" });
      return;
    }

    const cleanRUT = rut.replace(/[^0-9kK]/g, "");
    if (!/^\d{1,8}[kK\d]$/.test(cleanRUT.replace("-", ""))) {
      res.status(400).json({ error: "Formato de RUT inválido" });
      return;
    }

    const uploadDir = path.join(__dirname, "../uploads", cleanRUT);
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }

    const ext = path.extname(archivo.originalname).toLowerCase();
    const filename = `file-${Date.now()}-${Math.round(
      Math.random() * 1e9
    )}${ext}`;
    const fullPath = path.join(uploadDir, filename);

    fs.writeFileSync(fullPath, archivo.buffer);

    const ruta = `/uploads/${cleanRUT}/${filename}`;
    const nuevo = await DocumentoCandidato.create({
      candidato_id: Number(candidato_id),
      documento_id: Number(documento_id),
      nombre: filename,
      nombre_para_mostrar,
      ruta,
    });

    res.status(201).json({ mensaje: "Documento guardado", documento: nuevo });
  } catch (error: any) {
    if (error.name === "SequelizeForeignKeyConstraintError") {
      res.status(400).json({ error: "El candidato o documento no existe" });
    } else {
      console.error("Error en uploadCandidatoDocumento:", error);
      res.status(500).json({ error: "Error interno del servidor" });
    }
  }
};

export const deleteFile = async (req: Request, res: Response) => {
  const id = decryptId(req.params.id);

  if (!id) {
    res.status(400).json({ error: "ID inválido" });
    return;
  }
  try {
    const doc: any = await DocumentoCandidato.findByPk(id);
    if (!doc) {
      res.status(404).json({ error: "Documento no encontrado" });
      return;
    }
    const rutaAbsoluta = path.join(__dirname, "..", doc.ruta);
    if (fs.existsSync(rutaAbsoluta)) {
      //fs.unlinkSync(rutaAbsoluta); // Elimina el archivo físico
    }

    await doc.destroy(); // Elimina el registro en la base de datos
    res.status(200).json({ mensaje: "Documento eliminado correctamente" });
  } catch (error) {
    console.error("Error al eliminar documento:", error);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};
