// src/controllers/convocatoria.controller.ts
import { Request, Response } from "express";
import Convocatoria from "../models/convocatoria";
import Institucion from "../models/institucion";
import Ciudad from "../models/ciudad";
import EstadoConvocatoria from "../models/EstadoConvocatoria";
import Cargo from "../models/cargo";
import { Op } from "sequelize";
import Jornada from "../models/jornada";
import Modalidades from "../models/modalidad";
import tipoVacante from "../models/tipoVacante";

export const getAll = async (req: Request, res: Response) => {
  try {
    const estadoQuery = req.query.estado_id;
    const queryOptions: any = {
      include: [
        Institucion,
        Ciudad,
        EstadoConvocatoria,
        Cargo,
        Jornada,
        Modalidades,
        tipoVacante,
      ],
      order: [["created_at", "DESC"]],
    };

    if (estadoQuery) {
      queryOptions.where = {
        estado_id: { [Op.lt]: estadoQuery },
      };
    }

    const convocatorias = await Convocatoria.findAll(queryOptions);
    res.json(convocatorias);
  } catch (error) {
    console.error(" Error al obtener convocatorias:", error);
    res.status(500).json({ message: "Error al obtener convocatorias", error });
  }
};

export const getById = async (req: Request, res: Response) => {
  const convocatoria = await Convocatoria.findByPk(req.params.id);
  if (!convocatoria) {
    res.status(404).json({ error: "No encontrada" });
    return;
  }
  res.json(convocatoria);
};

export const createConvocatoria = async (req: Request, res: Response) => {
  try {
    const nueva = await Convocatoria.create(req.body);
    res.status(201).json(nueva);
  } catch (error) {
    res.status(400).json({ mensaje: "Error al crear convocatoria", error });
  }
};

export const contarConvocatorias = async (req: Request, res: Response) => {
  try {
    const currentYear = new Date().getFullYear();

    // 1. Disponibles (estado_id = 1)
    const disponibles = await Convocatoria.count({
      where: {
        estado_id: {
          [Op.lte]: 3,
        },
      },
    });

    // 2. Creadas en el año actual
    const creadasEsteAnio = await Convocatoria.count({
      where: {
        created_at: {
          [Op.gte]: new Date(`${currentYear}-01-01T00:00:00Z`),
          [Op.lt]: new Date(`${currentYear + 1}-01-01T00:00:00Z`),
        },
      },
    });

    // 3. Registradas (todas las existentes)
    const registradas = await Convocatoria.count();

    res.json({
      disponibles,
      creadasEsteAnio,
      registradas,
    });
  } catch (error) {
    console.error("Error al contar convocatorias:", error);
    res.status(500).json({ message: "Error en el servidor" });
  }
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
