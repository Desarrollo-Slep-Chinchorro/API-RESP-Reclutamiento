import { Request, Response } from "express";
import CategoriaCargo from "../models/categoria_cargos";

export const getAllCategoriaCargos = async (_req: Request, res: Response) => {
  try {
    const categoria_cargos = await CategoriaCargo.findAll();
    res.json(categoria_cargos);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener categoria_cargos", error });
    return;
  }
};

/* export const getCargoById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const cargo = await Cargo.findByPk(id);
    if (!cargo) {
      res.status(404).json({ message: "Cargo no encontrado" });
      return;
    }
    res.json(cargo);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener cargo", error });
    return;
  }
};

export const createCargo = async (req: Request, res: Response) => {
  try {
    const newCargo = await Cargo.create(req.body);
    res.status(201).json(newCargo);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al crear cargo", error });
    return;
  }
};

export const updateCargo = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await Cargo.update(req.body, { where: { id } });
    if (!updated) {
      res.status(404).json({ message: "Cargo no encontrado" });
      return;
    }
    const updatedCargo = await Cargo.findByPk(id);
    res.json(updatedCargo);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al actualizar cargo", error });
    return;
  }
};

export const deleteCargo = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await Cargo.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Cargo no encontrado" });
      return;
    }
    res.json({ message: "Cargo eliminado" });
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al eliminar cargo", error });
    return;
  }
}; */
