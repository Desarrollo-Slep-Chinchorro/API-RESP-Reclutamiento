// src/controllers/convocatoria.controller.ts
import { Request, Response } from "express";
import Convocatoria from "../models/convocatoria";
import Institucion from "../models/institucion";
import Ciudad from "../models/ciudad";
import EstadoConvocatoria from "../models/EstadoConvocatoria";
import Cargo from "../models/cargo";

export const getAll = async (_req: Request, res: Response) => {
  const convocatorias = await Convocatoria.findAll({
    include: [Institucion, Ciudad, EstadoConvocatoria, Cargo],
  });
  res.json(convocatorias);
};

export const getById = async (req: Request, res: Response) => {
  const convocatoria = await Convocatoria.findByPk(req.params.id);
  if (!convocatoria) {
    res.status(404).json({ error: "No encontrada" });
    return;
  }
  res.json(convocatoria);
};

export const create = async (req: Request, res: Response) => {
  const nueva = await Convocatoria.create(req.body);
  res.status(201).json(nueva);
};

export const update = async (req: Request, res: Response) => {
  const convocatoria = await Convocatoria.findByPk(req.params.id);
  if (!convocatoria) {
    res.status(404).json({ error: "No encontrada" });
    return;
  }

  await convocatoria.update(req.body);
  res.json(convocatoria);
};

export const remove = async (req: Request, res: Response) => {
  const convocatoria = await Convocatoria.findByPk(req.params.id);
  if (!convocatoria) {
    res.status(404).json({ error: "No encontrada" });
    return;
  }

  await convocatoria.destroy();
  res.status(204).send();
};
