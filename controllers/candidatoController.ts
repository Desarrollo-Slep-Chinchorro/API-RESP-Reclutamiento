import { Request, Response } from "express";
import Candidato from "../models/candidato";
import CandidatosCargos from "../models/candidatos_cargos";
import db from "../BD/connection";
import CandidatosCiudades from "../models/candidatos_ciudades";
import CandidatosJornadas from "../models/candidatos_jornadas";
import CandidatosModalidades from "../models/candidatos_modalidades";
import Modalidades from "../models/modalidad";
import Cargo from "../models/cargo";
import Ciudad from "../models/ciudad";
import Jornada from "../models/jornada";
import EstadoCivil from "../models/estado_civil";
import nivelEducacion from "../models/nivel_educacion";
import Nacionalidad from "../models/nacionalidad";
import TituloProfesional from "../models/titulo_profesional";
import Comentario from "../models/comentario";
import Comuna from "../models/comuna";
import Region from "../models/region";

export const getAllCandidatos = async (req: Request, res: Response) => {
  try {
    const candidatos = await Candidato.findAll({
      include: [
        Modalidades,
        Cargo,
        Ciudad,
        Jornada,
        EstadoCivil,
        nivelEducacion,
        Nacionalidad,
        TituloProfesional,
        {
          model: Comentario,
          include: [
            {
              model: Candidato,
              attributes: ["nombre_completo"], // Solo este campo
            },
          ],
        },
      ],
    });
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
    const candidato = await Candidato.findByPk(id, {
      include: [
        { model: Comuna, include: [Region] },
        {
          model: Cargo,
          attributes: ["id", "nombre"],
          through: { attributes: [] },
          as: "cargos",
        },
        {
          model: Jornada,
          attributes: ["id", "nombre"],
          through: { attributes: [] },
          as: "jornadas",
        },
        {
          model: Ciudad,
          attributes: ["id", "nombre"],
          through: { attributes: [] },
          as: "ciudades",
        },
        {
          model: Modalidades,
          attributes: ["id", "nombre"],
          through: { attributes: [] },
          as: "modalidades_horarias",
        },
      ],
    });
    if (!candidato) {
      res.status(404).json({ message: "Candidato no encontrado" });
      return;
    }
    res.json(candidato);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener candidato", error });
  }
};

/* export const updateCandidato = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { datos } = req.body;
  const { cargos: nuevosCargos = [], ...datosNuevos } = datos;

  console.log("id", id);
  console.log("req.body", req.body);
  console.log("nuevosCargos", nuevosCargos);
  res.json(datos);

  const transaction = await db.transaction();

  try {
    const candidatoActual = await Candidato.findByPk(id, { transaction });

    if (!candidatoActual) {
      await transaction.rollback();
      res.status(404).json({ message: "Candidato no encontrado" });
      return;
    }

    const datosHanCambiado = Object.entries(datosNuevos).some(
      ([key, nuevoValor]) => candidatoActual.get(key) !== nuevoValor
    );

    if (datosHanCambiado) {
      await Candidato.update(datosNuevos, {
        where: { id },
        transaction,
      });
    }

    const cargosActuales = await CandidatosCargos.findAll({
      where: { candidato_id: id },
      transaction,
    });

    const idsActuales = cargosActuales.map((c: any) => c.cargo_id).sort();
    const idsNuevos = nuevosCargos.map((c: any) => c.id).sort();

    const cargosHanCambiado = !(
      idsActuales.length === idsNuevos.length &&
      idsActuales.every((val, index) => val === idsNuevos[index])
    );

    if (cargosHanCambiado) {
      await CandidatosCargos.destroy({
        where: { candidato_id: id },
        transaction,
      });

      if (idsNuevos.length > 0) {
        await CandidatosCargos.bulkCreate(
          idsNuevos.map((cargoId: any) => ({
            candidato_id: Number(id),
            cargo_id: cargoId,
          })),
          { transaction }
        );
      }
    }

    await transaction.commit();

    const candidatoFinal = await Candidato.findByPk(id, {
      include: [{ model: CandidatosCargos, as: "cargos" }],
    });

    res.json(candidatoFinal);
    return;
  } catch (error: any) {
    await transaction.rollback();
    console.error("Error updating candidato:", error);
    res.status(400).json({
      message: "Error al actualizar candidato",
      error: error.message,
    });
    return;
  }
}; */

export const updateCandidato = async (req: Request, res: Response) => {
  const { id } = req.params;
  const {
    cargos = [],
    ciudades_seleccionadas = [],
    jornadas_seleccionadas = [],
    modalidades_seleccionadas = [],
    ...datosNuevos
  } = req.body;

  const transaction = await db.transaction();

  try {
    const candidatoActual = await Candidato.findByPk(id, { transaction });

    if (!candidatoActual) {
      await transaction.rollback();
      res.status(404).json({ message: "Candidato no encontrado" });
      return;
    }

    // 🔍 Validar cambios en campos simples
    const datosHanCambiado = Object.entries(datosNuevos).some(
      ([key, nuevoValor]) => candidatoActual.get(key) !== nuevoValor
    );

    if (datosHanCambiado) {
      await Candidato.update(datosNuevos, {
        where: { id },
        transaction,
      });
    }

    // 🔄 Validar y sincronizar relaciones intermedias
    const sincronizarRelacion = async (
      modelo: any,
      campo: string,
      nuevosIds: number[]
    ) => {
      const actuales = await modelo.findAll({
        where: { candidato_id: id },
        transaction,
      });

      const actualesIds = actuales.map((r: any) => r[campo]).sort();
      const nuevosIdsOrdenados = [...new Set(nuevosIds)].sort(); // Elimina duplicados

      const hanCambiado =
        actualesIds.length !== nuevosIdsOrdenados.length ||
        !actualesIds.every(
          (val: number, i: number) => val === nuevosIdsOrdenados[i]
        );

      if (hanCambiado) {
        await modelo.destroy({ where: { candidato_id: id }, transaction });

        if (nuevosIdsOrdenados.length > 0) {
          const registros = nuevosIdsOrdenados.map((valorId: number) => ({
            candidato_id: Number(id),
            [campo]: valorId,
          }));
          await modelo.bulkCreate(registros, { transaction });
        }
      }
    };

    await sincronizarRelacion(CandidatosCargos, "cargo_id", cargos);
    await sincronizarRelacion(
      CandidatosCiudades,
      "ciudades_id",
      ciudades_seleccionadas
    );
    await sincronizarRelacion(
      CandidatosJornadas,
      "jornada_id",
      jornadas_seleccionadas
    );
    await sincronizarRelacion(
      CandidatosModalidades,
      "modalidad_horaria_id",
      modalidades_seleccionadas
    );

    await transaction.commit();

    //  Ajuste: Sequelize usará el nombre del modelo si no hay alias
    const candidatoFinal = await Candidato.findByPk(id, {
      include: [
        { model: CandidatosCargos }, // candidato.CandidatosCargos
        { model: CandidatosCiudades }, // candidato.CandidatosCiudades
        { model: CandidatosJornadas }, // candidato.CandidatosJornadas
        { model: CandidatosModalidades }, // candidato.CandidatosModalidades
      ],
    });

    res.json(candidatoFinal);
    return;
  } catch (error: any) {
    await transaction.rollback();
    console.error("Error updating candidato:", error);
    res.status(400).json({
      message: "Error al actualizar candidato",
      error: error.message,
    });
    return;
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
