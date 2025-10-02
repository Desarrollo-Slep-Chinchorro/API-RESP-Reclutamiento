import { Request, Response } from "express";
import Comentario from "../models/comentario";

export const getAllComentarios = async (_req: Request, res: Response) => {
  try {
    const comentarios = await Comentario.findAll();
    res.json(comentarios);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener comentarios", error });
    return;
  }
};

export const getComentarioById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const comentario = await Comentario.findByPk(id);
    if (!comentario) {
      res.status(404).json({ message: "Comentario no encontrado" });
      return;
    }
    res.json(comentario);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener comentario", error });
    return;
  }
};

export const createComentario = async (req: Request, res: Response) => {
  try {
    const { Candidato, ...comentario } = req.body;
    console.log("body", comentario);

    const newComentario = await Comentario.create(comentario);
    res.status(201).json(newComentario);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al crear comentario", error });
    return;
  }
};

export const updateComentario = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await Comentario.update(req.body, { where: { id } });
    if (!updated) {
      res.status(404).json({ message: "Comentario no encontrado" });
      return;
    }
    const updatedComentario = await Comentario.findByPk(id);
    res.json(updatedComentario);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al actualizar comentario", error });
    return;
  }
};

export const deleteComentario = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await Comentario.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Comentario no encontrada" });
      return;
    }
    res.json({ message: "Comentario eliminado" });
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al eliminar comentario", error });
    return;
  }
};
