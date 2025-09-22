import { Request, Response } from "express";
import Jornada from "../models/jornada";

export const createMensaje = async (req: Request, res: Response) => {
  try {
    const { name, email, mensaje, rut } = req.body;

    //const newMensaje = await Mensaje.create(req.body);
    //res.status(201).json(newMensaje);
  } catch (error) {
    res.status(400).json({ mensaje: "Error al crear mensaje", error });
  }
};

export const getAllJornadas = async (req: Request, res: Response) => {
  try {
    const jornadas = await Jornada.findAll();
    res.json(jornadas);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener jornadas", error });
  }
};
