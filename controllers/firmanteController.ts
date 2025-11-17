import { Request, Response } from "express";
import Firmante from "../models/firmantes";

export const getAllFirmantes = async (_req: Request, res: Response) => {
  try {
    const firmantes = await Firmante.findAll();
    res.json(firmantes);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener firmantes", error });
    return;
  }
};

export const getFirmanteById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const firmante = await Firmante.findByPk(id);
    if (!firmante) {
      res.status(404).json({ message: "firmante no encontrado" });
      return;
    }
    res.json(firmante);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener firmante", error });
    return;
  }
};

export const createFirmante = async (req: Request, res: Response) => {
  try {
    const newFirmante = await Firmante.create(req.body);
    res.status(201).json(newFirmante);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al crear firmante", error });
    return;
  }
};

export const updateFirmante = async (req: Request, res: Response) => {
  const { id } = req.params;
};

export const deleteFirmante = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await Firmante.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Firmante no encontrado" });
      return;
    }
    res.json({ message: "Firmante eliminado" });
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al eliminar Firmante", error });
    return;
  }
};
