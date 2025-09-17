import { Request, Response } from "express";
import Mensaje from "../models/mensaje";
import db from "../BD/connection";

export const getAllMensajes = async (req: Request, res: Response) => {
  try {
    const mensajes = await Mensaje.findAll();
    res.json(mensajes);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener mensajes", error });
  }
};

export const createMensaje = async (req: Request, res: Response) => {
  try {
    const newMensaje = await Mensaje.create(req.body);

    res.status(201).json(newMensaje);
  } catch (error) {
    res.status(400).json({ message: "Error al crear mensaje", error });
  }
};
