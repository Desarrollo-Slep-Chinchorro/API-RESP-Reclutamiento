// controllers/postulacionController.ts
import { Request, Response } from "express";
import { Op } from "sequelize";
import Postulacion from "../models/postulacion";
import Convocatoria from "../models/convocatoria";
import Candidato from "../models/candidato";
import Cargo from "../models/cargo";
import Institucion from "../models/institucion";

export const crearPostulacion = async (req: Request, res: Response) => {
  const { candidato_id, convocatoria_id } = req.body;

  if (!candidato_id || !convocatoria_id) {
    res.status(400).json({ error: "Faltan campos obligatorios" });
    return;
  }

  try {
    const existente = await Postulacion.findOne({
      where: { candidato_id, convocatoria_id },
    });

    if (existente) {
      res.status(409).json({
        error: "Ya existe una postulación para esta convocatoria",
      });
      return;
    }

    const nueva = await Postulacion.create({ candidato_id, convocatoria_id });
    res.status(201).json(nueva);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error al crear postulación", detalle: error });
  }
};

export const listarPostulaciones = async (_: Request, res: Response) => {
  try {
    const postulaciones = await Postulacion.findAll({
      include: [
        {
          model: Candidato,
        },
        {
          model: Convocatoria,
        },
      ],
    });
    res.json(postulaciones);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error al obtener postulaciones", detalle: error });
  }
};

export const agrupadasPorConvocatoriaEstadoAsc = async (
  req: Request,
  res: Response
) => {
  try {
    let whereEstado;
    if (req.params.estado) {
      whereEstado = { estado_id: { [Op.lte]: req.params.estado } };
    }

    const postulaciones = await Postulacion.findAll({
      include: [
        {
          model: Convocatoria,
          where: whereEstado,
          include: [Cargo, Institucion],
        },
        {
          model: Candidato,
        },
      ],
      order: [[Convocatoria, "estado_id", "ASC"]],
    });

    const agrupadas: Record<number, { convocatoria: any; candidatos: any[] }> =
      {};

    postulaciones.forEach((postulacion: any) => {
      const id = postulacion.convocatoria_id;
      if (!agrupadas[id]) {
        agrupadas[id] = {
          convocatoria: postulacion.Convocatorium,
          candidatos: [],
        };
      }

      const candidatoConEstado = {
        ...postulacion.Candidato.get({ plain: true }),
        estado: postulacion.estado,
      };

      agrupadas[id].candidatos.push(candidatoConEstado);
    });

    res.json(agrupadas);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error al agrupar postulaciones", detalle: error });
  }
};
