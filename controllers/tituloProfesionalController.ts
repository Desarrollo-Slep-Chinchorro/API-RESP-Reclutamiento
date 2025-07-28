import { Request, Response } from "express";
import TituloProfesional from "../models/titulo_profesional";

export const getAllTitulosProfesionales = async (
  _req: Request,
  res: Response
) => {
  try {
    const list = await TituloProfesional.findAll();
    res.json(list);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener títulos profesionales", error });
    return;
  }
};

export const getTituloProfesionalById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const titulo = await TituloProfesional.findByPk(id);
    if (!titulo) {
      res.status(404).json({ message: "Título profesional no encontrado" });
      return;
    }
    res.json(titulo);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener título profesional", error });
    return;
  }
};

export const createTituloProfesional = async (req: Request, res: Response) => {
  try {
    const newTitulo = await TituloProfesional.create(req.body);
    res.status(201).json(newTitulo);
    return;
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error al crear título profesional", error });
    return;
  }
};

export const updateTituloProfesional = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await TituloProfesional.update(req.body, {
      where: { id },
    });
    if (!updated) {
      res.status(404).json({ message: "Título profesional no encontrado" });
      return;
    }
    const updatedTitulo = await TituloProfesional.findByPk(id);
    res.json(updatedTitulo);
    return;
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error al actualizar título profesional", error });
    return;
  }
};

export const deleteTituloProfesional = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await TituloProfesional.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Título profesional no encontrado" });
      return;
    }
    res.json({ message: "Título profesional eliminado" });
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al eliminar título profesional", error });
    return;
  }
};
