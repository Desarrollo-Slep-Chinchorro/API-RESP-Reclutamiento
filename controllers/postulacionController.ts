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

    // TRANSFORMAR LA RESPUESTA PARA EL FRONTEND
    const respuestaFrontend = convocatorias.map((convocatoria) => {
      const convocatoriaPlain = convocatoria.get({ plain: true });

      return {
        convocatoria: {
          id: convocatoriaPlain.id,
          codigo: convocatoriaPlain.codigo,
          cargo_id: convocatoriaPlain.cargo_id,
          ciudad_id: convocatoriaPlain.ciudad_id,
          institucion_id: convocatoriaPlain.institucion_id,
          fecha_cierre: convocatoriaPlain.fecha_cierre,
          descripcion: convocatoriaPlain.descripcion,
          requisitos: convocatoriaPlain.requisitos,
          created_at: convocatoriaPlain.created_at,
          estado_id: convocatoriaPlain.estado_id,
          modalidad_id: convocatoriaPlain.modalidad_id,
          tipo_vacante_id: convocatoriaPlain.tipo_vacante_id,
          jornada_id: convocatoriaPlain.jornada_id,
          categoria_cargo_id: convocatoriaPlain.categoria_cargo_id,
          // Relaciones
          cargo: convocatoriaPlain.cargo,
          institucione: convocatoriaPlain.institucione,
          estado_convocatorium: convocatoriaPlain.estado_convocatorium,
        },
        candidatos:
          convocatoriaPlain.Postulacions?.map((postulacion: any) => ({
            // Datos de la postulación
            id: postulacion.Candidato?.id,
            postulacion_id: postulacion.id,
            estado_postulacion: postulacion.estado,
            created_at_postulacion: postulacion.created_at,
            // Datos del candidato
            rut: postulacion.Candidato?.rut,
            nombre_completo: postulacion.Candidato?.nombre_completo,
            titulo_profesional_id: postulacion.Candidato?.titulo_profesional_id,
            telefono: postulacion.Candidato?.telefono,
            correo: postulacion.Candidato?.correo,
            estado_candidato_id: postulacion.Candidato?.estado_candidato_id,
            nacionalidad_id: postulacion.Candidato?.nacionalidad_id,
            estado_civil_id: postulacion.Candidato?.estado_civil_id,
            direccion: postulacion.Candidato?.direccion,
            comuna_id: postulacion.Candidato?.comuna_id,
            usuario_id: postulacion.Candidato?.usuario_id,
            fecha_nacimiento: postulacion.Candidato?.fecha_nacimiento,
            presentacion: postulacion.Candidato?.presentacion,
            tipo_vacante_nuevo: postulacion.Candidato?.tipo_vacante_nuevo,
            tipo_vacante_reemplazo:
              postulacion.Candidato?.tipo_vacante_reemplazo,
            categoria_funcionaria_id:
              postulacion.Candidato?.categoria_funcionaria_id,
            nivel_educacion_id: postulacion.Candidato?.nivel_educacion_id,
            especialidad: postulacion.Candidato?.especialidad,
            created_at: postulacion.Candidato?.created_at,
            updated_at: postulacion.Candidato?.updated_at,
            // Relaciones del candidato
            modalidades_horarias:
              postulacion.Candidato?.modalidades_horarias || [],
            cargos: postulacion.Candidato?.cargos || [],
            ciudades: postulacion.Candidato?.ciudades || [],
            jornadas: postulacion.Candidato?.jornadas || [],
            estados_civile: postulacion.Candidato?.estados_civile,
            nivel_educacion: postulacion.Candidato?.nivel_educacion,
            nacionalidade: postulacion.Candidato?.nacionalidade,
            titulos_profesionale: postulacion.Candidato?.titulos_profesionale,
            comentarios: postulacion.Candidato?.comentarios || [],
          })) || [], // Array vacío si no hay postulaciones
      };
    });

    console.log("🔍 CONVOCATORIAS ENCONTRADAS:", respuestaFrontend.length);
    console.log(
      "🔍 ESTRUCTURA FINAL:",
      JSON.stringify(respuestaFrontend[0], null, 2)
    );

    res.json(respuestaFrontend);
  } catch (error) {
    console.error("❌ ERROR:", error);
    res.status(500).json({
      error: "Error al obtener convocatorias",
      detalle: error instanceof Error ? error.message : error,
    });
  }
};
