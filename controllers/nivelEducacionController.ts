import { Request, Response } from "express";
import nivelEducacion from "../models/nivel_educacion";

export const createMensaje = async (req: Request, res: Response) => {
  try {
    const { name, email, mensaje, rut } = req.body;

    //const newMensaje = await Mensaje.create(req.body);
    //res.status(201).json(newMensaje);
  } catch (error) {
    res.status(400).json({ mensaje: "Error al crear mensaje", error });
  }
};

export const getAllnivelEducacion = async (req: Request, res: Response) => {
  try {
    const nivel_educacion = await nivelEducacion.findAll();
    res.json(nivel_educacion);
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener nivel educacion", error });
  }
};
