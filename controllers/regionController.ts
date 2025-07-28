import { Request, Response } from "express";
import Region from "../models/region";
import Comuna from "../models/comuna";

export const getAllRegions = async (_req: Request, res: Response) => {
  try {
    const regions = await Region.findAll({
      include: [{ model: Comuna }],
    });
    res.json(regions);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener regiones", error });
    return;
  }
};

export const getRegionById = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const region = await Region.findByPk(id);
    if (!region) {
      res.status(404).json({ message: "Región no encontrada" });
      return;
    }
    res.json(region);
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al obtener región", error });
    return;
  }
};

export const createRegion = async (req: Request, res: Response) => {
  try {
    const newRegion = await Region.create(req.body);
    res.status(201).json(newRegion);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al crear región", error });
    return;
  }
};

export const updateRegion = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await Region.update(req.body, { where: { id } });
    if (!updated) {
      res.status(404).json({ message: "Región no encontrada" });
      return;
    }
    const updatedRegion = await Region.findByPk(id);
    res.json(updatedRegion);
    return;
  } catch (error) {
    res.status(400).json({ message: "Error al actualizar región", error });
    return;
  }
};

export const deleteRegion = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await Region.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Región no encontrada" });
      return;
    }
    res.json({ message: "Región eliminada" });
    return;
  } catch (error) {
    res.status(500).json({ message: "Error al eliminar región", error });
    return;
  }
};
