import { Request, Response } from "express";
import db from "../BD/connection";
import Institucion from "../models/institucion";

export const getAllInstituciones = async (req: Request, res: Response) => {
  try {
    const instituciones = await Institucion.findAll();
    res.json(instituciones);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener Institucion", error });
  }
};

export const getCandidatoById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const institucion = await Institucion.findByPk(id);
    if (!institucion) {
      res.status(404).json({ message: "institucion no encontrado" });
      return;
    }
    res.json(institucion);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener institucion", error });
  }
};
