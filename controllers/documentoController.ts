import { Request, Response } from "express";
import Documento from "../models/documento";

export const getAllDocumentos = async (_req: Request, res: Response) => {
  try {
    const documentos = await Documento.findAll();
    res.json(documentos);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener documentos", error });
    return;
  }
};

export const getDocumentoById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const documento = await Documento.findByPk(id);
    if (!documento) {
      res.status(404).json({ message: "Documento no encontrado" });
      return;
    }
    res.json(documento);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener documento", error });
    return;
  }
};

export const createDocumento = async (req: Request, res: Response) => {
  try {
    const newDocumento = await Documento.create(req.body);
    res.status(201).json(newDocumento);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al crear documento", error });
    return;
  }
};

export const updateDocumento = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await Documento.update(req.body, { where: { id } });
    if (!updated) {
      res.status(404).json({ message: "Documento no encontrado" });
      return;
    }
    const updatedDocumento = await Documento.findByPk(id);
    res.json(updatedDocumento);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al actualizar documento", error });
    return;
  }
};

export const deleteDocumento = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await Documento.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Documento no encontrado" });
      return;
    }
    res.json({ message: "Documento eliminado" });
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al eliminar documento", error });
    return;
  }
};
