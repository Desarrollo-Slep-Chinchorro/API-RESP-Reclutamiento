import { Request, Response } from "express";
import Candidato from "../models/candidato";

export const getAllCandidatos = async (req: Request, res: Response) => {
  try {
    const candidatos = await Candidato.findAll();
    res.json(candidatos);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener candidatos", error });
  }
};

export const createCandidato = async (req: Request, res: Response) => {
  try {
    const newCandidato = await Candidato.create(req.body);
    res.status(201).json(newCandidato);
  } catch (error) {
    res.status(400).json({ message: "Error al crear candidato", error });
  }
};

export const getCandidatoById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const candidato = await Candidato.findByPk(id);
    if (!candidato) {
      res.status(404).json({ message: "Candidato no encontrado" });
      return;
    }
    res.json(candidato);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener candidato", error });
  }
};

export const updateCandidato = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await Candidato.update(req.body, { where: { id } });
    if (!updated) {
      res.status(404).json({ message: "Candidato no encontrado" });
      return;
    }
    const updatedCandidato = await Candidato.findByPk(id);
    res.json(updatedCandidato);
  } catch (error) {
    res.status(400).json({ message: "Error al actualizar candidato", error });
  }
};

export const deleteCandidato = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await Candidato.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Candidato no encontrado" });
      return;
    }
    res.json({ message: "Candidato eliminado" });
  } catch (error) {
    res.status(500).json({ message: "Error al eliminar candidato", error });
  }
};

// Búsqueda avanzada por RUT
export const searchCandidatoByRut = async (req: Request, res: Response) => {
  const { rut } = req.query;
  try {
    const candidatos = await Candidato.findAll({ where: { rut } });
    res.json(candidatos);
  } catch (error) {
    res.status(500).json({ message: "Error en búsqueda de candidato", error });
  }
};
