import { Request, Response } from "express";
import tipoVacante from "../models/tipoVacante";

export const createMensaje = async (req: Request, res: Response) => {
  try {
    const { name, email, mensaje, rut } = req.body;

    //const newMensaje = await Mensaje.create(req.body);
    //res.status(201).json(newMensaje);
  } catch (error) {
    res.status(400).json({ mensaje: "Error al crear mensaje", error });
  }
};

export const getAllTipo_vacantes = async (req: Request, res: Response) => {
  try {
    const TipoVacabte = await tipoVacante.findAll();
    res.json(TipoVacabte);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener Tipo Vacabte", error });
  }
};
