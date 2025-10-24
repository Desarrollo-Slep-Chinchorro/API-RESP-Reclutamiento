// controllers/CartasOfertasController.ts
import { Request, Response } from "express";
import CartaOferta from "../models/carta_oferta";
import Candidato from "../models/candidato";
import Convocatoria from "../models/convocatoria";
import Institucion from "../models/institucion";
import Director from "../models/director";
import Cargo from "../models/cargo";
import Jornada from "../models/jornada";

const CartasOfertasController = {
  async listar(req: Request, res: Response) {
    try {
      const cartas = await CartaOferta.findAll();
      res.json(cartas);
    } catch (error) {
      console.error("Error al listar cartas:", error);
      res.status(500).json({ error: "Error interno al listar cartas" });
    }
  },

  async obtenerPorId(req: Request, res: Response) {
    try {
      const carta = await CartaOferta.findByPk(req.params.id, {
        include: [
          Cargo,
          Jornada,
          Candidato,
          Convocatoria,
          {
            model: Institucion,
            include: [Director],
          },
        ],
      });
      if (!carta) {
        res.status(404).json({ error: "Carta no encontrada" });
        return;
      }
      res.json(carta);
    } catch (error) {
      console.error("Error al obtener carta:", error);
      res.status(500).json({ error: "Error interno al obtener carta" });
    }
  },

  async crear(req: Request, res: Response) {
    try {
      const nuevaCarta = await CartaOferta.create(req.body);
      res.status(201).json(nuevaCarta);
    } catch (error) {
      console.error("Error al crear carta:", error);
      res.status(400).json({ error: "Datos inválidos o incompletos" });
    }
  },

  async actualizar(req: Request, res: Response) {
    try {
      const carta = await CartaOferta.findByPk(req.params.id);
      if (!carta) {
        res.status(404).json({ error: "Carta no encontrada" });
        return;
      }

      await carta.update(req.body);
      res.json(carta);
    } catch (error) {
      console.error("Error al actualizar carta:", error);
      res.status(400).json({ error: "Error al actualizar carta" });
    }
  },

  async eliminar(req: Request, res: Response) {
    try {
      const carta = await CartaOferta.findByPk(req.params.id);
      if (!carta) {
        res.status(404).json({ error: "Carta no encontrada" });
        return;
      }
      await carta.destroy();
      res.status(204).send();
    } catch (error) {
      console.error("Error al eliminar carta:", error);
      res.status(500).json({ error: "Error al eliminar carta" });
    }
  },
};

export default CartasOfertasController;
