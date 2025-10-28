// controllers/CartasOfertasController.ts
import { Request, Response } from "express";
import CartaOferta from "../models/carta_oferta";
import Candidato from "../models/candidato";
import Convocatoria from "../models/convocatoria";
import Institucion from "../models/institucion";
import Director from "../models/director";
import Cargo from "../models/cargo";
import Jornada from "../models/jornada";
import {
  enviarCorreo_para_Aprobacion,
  generarTokenAprobacion,
  validarTokenAprobacion,
} from "../utils/validaciones";

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
      const { dato_envio, ...datos } = req.body;

      const carta: any = await CartaOferta.findByPk(req.params.id, {
        include: [
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
      if (dato_envio === 1) {
        datos.fecha_envio_dir = new Date();
        datos.estado = 2;
        const sendToken = generarTokenAprobacion(carta.id);
        await enviarCorreo_para_Aprobacion(carta, sendToken);
      }
      if (dato_envio == 2) {
        datos.fecha_apr_director = new Date();
        datos.estado = 3;
      }
      await carta.update(datos);
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

  async obtenerCartaPorToken(req: Request, res: Response) {
    const { token } = req.params;
    console.log("Token", token);

    try {
      const { carta_id } = validarTokenAprobacion(token);
      const carta = await CartaOferta.findByPk(carta_id, {
        include: [
          {
            model: Institucion,
            include: [Director],
          },
          "cargo",
          "jornada",
          "Candidato",
        ],
      });
      if (!carta) {
        res.status(404).json({ mensaje: "Carta no encontrada" });
        return;
      }
      res.json(carta);
    } catch (error) {
      res.status(401).json({ mensaje: "Token inválido o expirado" });
    }
  },

  async aprobarCartaPorToken(req: Request, res: Response) {
    const { token } = req.params;
    const { fecha_ingreso, horas_pactadas } = req.body;

    try {
      const { carta_id } = validarTokenAprobacion(token);
      const carta = await CartaOferta.findByPk(carta_id);
      if (!carta) {
        res.status(404).json({ mensaje: "Carta no encontrada" });
        return;
      }

      await carta.update({
        estado: 3,
        fecha_ingreso,
        horas_pactadas,
        fecha_apr_director: new Date(),
      });

      res.json({ mensaje: "Carta aprobada correctamente" });
    } catch (error) {
      res.status(401).json({ mensaje: "Token inválido o expirado" });
    }
  },
};

export default CartasOfertasController;
