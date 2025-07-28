import { Request, Response } from "express";
import EstadoCivil from "../models/estado_civil";

export const getAllEstadosCiviles = async (_req: Request, res: Response) => {
  try {
    const estados = await EstadoCivil.findAll();
    res.json(estados);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener estados civiles", error });
    return;
  }
};

export const getEstadoCivilById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const estado = await EstadoCivil.findByPk(id);
    if (!estado) {
      res.status(404).json({ message: "Estado civil no encontrado" });
      return;
    }
    res.json(estado);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener estado civil", error });
    return;
  }
};

export const createEstadoCivil = async (req: Request, res: Response) => {
  try {
    const newEstado = await EstadoCivil.create(req.body);
    res.status(201).json(newEstado);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al crear estado civil", error });
    return;
  }
};

export const updateEstadoCivil = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await EstadoCivil.update(req.body, { where: { id } });
    if (!updated) {
      res.status(404).json({ message: "Estado civil no encontrado" });
      return;
    }
    const updatedEstado = await EstadoCivil.findByPk(id);
    res.json(updatedEstado);
    return;
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error al actualizar estado civil", error });
    return;
  }
};

export const deleteEstadoCivil = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await EstadoCivil.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Estado civil no encontrado" });
      return;
    }
    res.json({ message: "Estado civil eliminado" });
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al eliminar estado civil", error });
    return;
  }
};
