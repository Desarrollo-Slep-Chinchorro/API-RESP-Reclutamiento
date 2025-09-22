import { Request, Response } from "express";
import Ciudad from "../models/ciudad";

export const createMensaje = async (req: Request, res: Response) => {
  try {
    const { name, email, mensaje, rut } = req.body;

    //const newMensaje = await Mensaje.create(req.body);
    //res.status(201).json(newMensaje);
  } catch (error) {
    res.status(400).json({ mensaje: "Error al crear mensaje", error });
  }
};

export const getAllCiudades = async (req: Request, res: Response) => {
  try {
    const ciudades = await Ciudad.findAll();
    res.json(ciudades);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener ciudades", error });
  }
};
