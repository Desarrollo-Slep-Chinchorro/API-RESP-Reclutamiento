import { Request, Response } from "express";
import CandidatosCargos from "../models/candidatos_cargos";

export const getAllCandidatosCargos = async (_req: Request, res: Response) => {
  try {
    const relations = await CandidatosCargos.findAll();
    res.json(relations);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener relaciones candidato-cargo", error });
    return;
  }
};

export const createCandidatoCargo = async (req: Request, res: Response) => {
  try {
    const newRelation = await CandidatosCargos.create(req.body);
    res.status(201).json(newRelation);
    return;
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error al crear relación candidato-cargo", error });
    return;
  }
};

export const deleteCandidatoCargo = async (req: Request, res: Response) => {
  const { candidato_id, cargo_id } = req.params;
  try {
    const deleted = await CandidatosCargos.destroy({
      where: { candidato_id, cargo_id },
    });
    if (!deleted) {
      res
        .status(404)
        .json({ message: "Relación candidato-cargo no encontrada" });
      return;
    }
    res.json({ message: "Relación candidato-cargo eliminada" });
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al eliminar relación candidato-cargo", error });
    return;
  }
};
