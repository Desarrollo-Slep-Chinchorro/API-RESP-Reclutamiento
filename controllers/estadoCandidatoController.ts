import { Request, Response } from "express";
import EstadoCandidato from "../models/estado_candidato";

export const getAllEstadoCandidatos = async (_req: Request, res: Response) => {
  try {
    const estados = await EstadoCandidato.findAll();
    res.json(estados);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener estados de candidatos", error });
    return;
  }
};

export const getEstadoCandidatoById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const estado = await EstadoCandidato.findByPk(id);
    if (!estado) {
      res.status(404).json({ message: "Estado de candidato no encontrado" });
      return;
    }
    res.json(estado);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener estado de candidato", error });
    return;
  }
};

export const createEstadoCandidato = async (req: Request, res: Response) => {
  try {
    const newEstado = await EstadoCandidato.create(req.body);
    res.status(201).json(newEstado);
    return;
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error al crear estado de candidato", error });
    return;
  }
};

export const updateEstadoCandidato = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await EstadoCandidato.update(req.body, { where: { id } });
    if (!updated) {
      res.status(404).json({ message: "Estado de candidato no encontrado" });
      return;
    }
    const updatedEstado = await EstadoCandidato.findByPk(id);
    res.json(updatedEstado);
    return;
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error al actualizar estado de candidato", error });
    return;
  }
};

export const deleteEstadoCandidato = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await EstadoCandidato.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Estado de candidato no encontrado" });
      return;
    }
    res.json({ message: "Estado de candidato eliminado" });
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al eliminar estado de candidato", error });
    return;
  }
};
