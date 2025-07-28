import { Request, Response } from "express";
import Nacionalidad from "../models/nacionalidad";

export const getAllNacionalidades = async (_req: Request, res: Response) => {
  try {
    const list = await Nacionalidad.findAll();
    res.json(list);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener nacionalidades", error });
    return;
  }
};

export const getNacionalidadById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const nat = await Nacionalidad.findByPk(id);
    if (!nat) {
      res.status(404).json({ message: "Nacionalidad no encontrada" });
      return;
    }
    res.json(nat);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener nacionalidad", error });
    return;
  }
};

export const createNacionalidad = async (req: Request, res: Response) => {
  try {
    const newNat = await Nacionalidad.create(req.body);
    res.status(201).json(newNat);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al crear nacionalidad", error });
    return;
  }
};

export const updateNacionalidad = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await Nacionalidad.update(req.body, { where: { id } });
    if (!updated) {
      res.status(404).json({ message: "Nacionalidad no encontrada" });
      return;
    }
    const updatedNat = await Nacionalidad.findByPk(id);
    res.json(updatedNat);
    return;
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error al actualizar nacionalidad", error });
    return;
  }
};

export const deleteNacionalidad = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await Nacionalidad.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Nacionalidad no encontrada" });
      return;
    }
    res.json({ message: "Nacionalidad eliminada" });
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al eliminar nacionalidad", error });
    return;
  }
};
