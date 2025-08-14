import { Request, Response } from "express";
import Candidato from "../models/candidato";
import CandidatosCargos from "../models/candidatos_cargos";
import db from "../BD/connection";

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
  const { datos } = req.body;
  const { cargos: nuevosCargos = [], ...datosNuevos } = datos;

  console.log("id", id);
  console.log("req.body", req.body);
  console.log("nuevosCargos", nuevosCargos);

  const transaction = await db.transaction();

  try {
    // 1. Get current candidate data
    const candidatoActual = await Candidato.findByPk(id, { transaction });

    if (!candidatoActual) {
      await transaction.rollback();
      res.status(404).json({ message: "Candidato no encontrado" });
      return;
    }

    // 2. Check if candidate data has changed
    const datosHanCambiado = Object.entries(datosNuevos).some(
      ([key, nuevoValor]) => candidatoActual.get(key) !== nuevoValor
    );

    // 3. Update if there are changes
    if (datosHanCambiado) {
      await Candidato.update(datosNuevos, {
        where: { id },
        transaction,
      });
    }

    // 4. Check if positions (cargos) have changed
    const cargosActuales = await CandidatosCargos.findAll({
      where: { candidato_id: id },
      transaction,
    });

    const idsActuales = cargosActuales.map((c: any) => c.cargo_id).sort();
    const idsNuevos = nuevosCargos.map(Number).sort();

    // Compare arrays efficiently
    const cargosHanCambiado = !(
      idsActuales.length === idsNuevos.length &&
      idsActuales.every((val, index) => val === idsNuevos[index])
    );

    if (cargosHanCambiado) {
      // Efficient bulk update using transaction
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

    // Get updated candidate with relations if needed
    const candidatoFinal = await Candidato.findByPk(id, {
      include: [
        /* any relations you want to include */
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
