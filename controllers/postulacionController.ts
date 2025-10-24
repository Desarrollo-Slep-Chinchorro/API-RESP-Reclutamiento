// controllers/postulacionController.ts
import { Request, Response } from "express";
import { Op } from "sequelize";
import Postulacion from "../models/postulacion";
import Convocatoria from "../models/convocatoria";
import Candidato from "../models/candidato";
import Cargo from "../models/cargo";
import Institucion from "../models/institucion";
import Modalidades from "../models/modalidad";
import Ciudad from "../models/ciudad";
import Jornada from "../models/jornada";
import Comentario from "../models/comentario";
import EstadoCivil from "../models/estado_civil";
import Nacionalidad from "../models/nacionalidad";
import nivelEducacion from "../models/nivel_educacion";
import TituloProfesional from "../models/titulo_profesional";
import EstadoConvocatoria from "../models/EstadoConvocatoria";
import CartaOferta from "../models/carta_oferta";

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

/* export const agrupadasPorConvocatoriaEstadoAsc = async (
  req: Request,
  res: Response
) => {
  try {
    let whereEstado: any = { estado_id: { [Op.lte]: 4 } }; // Valor por defecto

    if (req.params.estado) {
      const estado = parseInt(req.params.estado);
      if (!isNaN(estado)) {
        whereEstado = { estado_id: { [Op.lte]: estado } };
      }
    }

    console.log("🔍 WHERE CONVOCATORIA:", whereEstado);

    const convocatorias = await Convocatoria.findAll({
      where: whereEstado, // Filtro en convocatorias
      include: [
        {
          model: Cargo,
        },
        {
          model: Institucion,
        },
        {
          model: EstadoConvocatoria,
        },
        {
          model: Postulacion, // LEFT JOIN con postulaciones
          required: false, // IMPORTANTE: LEFT JOIN (incluye convocatorias sin postulaciones)
          include: [
            {
              model: Candidato,
              include: [
                {
                  model: Modalidades,
                },
                {
                  model: Cargo,
                },
                {
                  model: Ciudad,
                },
                {
                  model: Jornada,
                },
                {
                  model: EstadoCivil,
                },
                {
                  model: nivelEducacion,
                },
                {
                  model: Nacionalidad,
                },
                {
                  model: TituloProfesional,
                },
                {
                  model: Comentario,
                  include: [
                    {
                      model: Candidato,
                      attributes: ["nombre_completo"],
                    },
                  ],
                },
              ],
            },
          ],
        },
      ],
      order: [["estado_id", "ASC"]],
    });

    console.log("🔍 CONVOCATORIAS ENCONTRADAS:", convocatorias.length);

    res.json(convocatorias);
  } catch (error) {
    console.error("❌ ERROR:", error);
    res.status(500).json({
      error: "Error al obtener convocatorias",
      detalle: error instanceof Error ? error.message : error,
    });
  }
}; */

export const agrupadasPorConvocatoriaEstadoAsc = async (
  req: Request,
  res: Response
) => {
  try {
    let whereEstado: any = { estado_id: { [Op.lte]: 4 } };

    if (req.params.estado) {
      const estado = parseInt(req.params.estado);
      if (!isNaN(estado)) {
        whereEstado = { estado_id: { [Op.lte]: estado } };
      }
    }

    const convocatorias = await Convocatoria.findAll({
      where: whereEstado,
      include: [
        {
          model: Cargo,
          as: "cargo", // Asegúrate que el alias coincida
        },
        {
          model: Institucion,
          as: "institucione", // Mantén este nombre si así está en tu BD
        },
        {
          model: EstadoConvocatoria,
          as: "estado_convocatorium", // Mantén este nombre
        },
        {
          model: CartaOferta,
          required: false,
        },
        {
          model: Postulacion,
          as: "Postulacions", // O el nombre que definiste en asociaciones
          required: false,
          include: [
            {
              model: Candidato,
              as: "Candidato",
              include: [
                // Solo incluye lo necesario para el frontend
                {
                  model: Modalidades,
                  as: "modalidades_horarias",
                },
                {
                  model: Cargo,
                  as: "cargos",
                },
                {
                  model: Ciudad,
                  as: "ciudades",
                },
                {
                  model: Jornada,
                  as: "jornadas",
                },
                {
                  model: EstadoCivil,
                  as: "estados_civile",
                },
                {
                  model: nivelEducacion,
                  as: "nivel_educacion",
                },
                {
                  model: Nacionalidad,
                  as: "nacionalidade",
                },
                {
                  model: TituloProfesional,
                  as: "titulos_profesionale",
                },
                {
                  model: Comentario,
                  as: "comentarios",
                },
              ],
            },
          ],
        },
      ],
      order: [["estado_id", "ASC"]],
    });

    res.json(convocatorias);
  } catch (error) {
    console.error("❌ ERROR:", error);
    res.status(500).json({
      error: "Error al obtener convocatorias",
      detalle: error instanceof Error ? error.message : error,
    });
  }
};
