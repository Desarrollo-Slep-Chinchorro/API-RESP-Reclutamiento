import { Request, Response } from "express";
import Comuna from "../models/comuna";

export const getAllComunas = async (_req: Request, res: Response) => {
  try {
    const comunas = await Comuna.findAll();
    res.json(comunas);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener comunas", error });
    return;
  }
};

export const getComunaById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const comuna = await Comuna.findByPk(id);
    if (!comuna) {
      res.status(404).json({ message: "Comuna no encontrada" });
      return;
    }
    res.json(comuna);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener comuna", error });
    return;
  }
};

export const createComuna = async (req: Request, res: Response) => {
  try {
    const newComuna = await Comuna.create(req.body);
    res.status(201).json(newComuna);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al crear comuna", error });
    return;
  }
};

export const updateComuna = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await Comuna.update(req.body, { where: { id } });
    if (!updated) {
      res.status(404).json({ message: "Comuna no encontrada" });
      return;
    }
    const updatedComuna = await Comuna.findByPk(id);
    res.json(updatedComuna);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al actualizar comuna", error });
    return;
  }
};

export const deleteComuna = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await Comuna.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Comuna no encontrada" });
      return;
    }
    res.json({ message: "Comuna eliminada" });
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al eliminar comuna", error });
    return;
  }
};
