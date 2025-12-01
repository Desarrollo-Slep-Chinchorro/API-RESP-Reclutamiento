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
  generateRandomNumericCode,
} from "../utils/validaciones";
import EstadoCartaOferta from "../models/estado_cartaOferta";
import EstadoCivil from "../models/estado_civil";
import Nacionalidad from "../models/nacionalidad";
import Ciudad from "../models/ciudad";
import CategoriaCargo from "../models/categoria_cargos";
import { Op } from "sequelize";

const CartasOfertasController = {
  async listar(req: Request, res: Response) {
    try {
      const { est } = req.query;

      const where: any = {};
      if (est) {
        const estados = String(est)
          .split(",")
          .map((e) => Number(e.trim()));

        where.estado = { [Op.in]: estados };
      }
      const cartas = await CartaOferta.findAll({
        where,
        include: [Candidato, Institucion, Cargo, EstadoCartaOferta],
      });
      res.json(cartas);
    } catch (error) {
      console.error("Error al listar cartas:", error);
      res.status(500).json({ error: "Error interno al listar cartas" });
    }
  },

  async obtenerPorId(req: Request, res: Response) {
    //
    try {
      const carta = await CartaOferta.findByPk(req.params.id, {
        include: [
          { model: Cargo, include: [CategoriaCargo] },
          Jornada,
          EstadoCartaOferta,
          {
            model: Candidato,
            include: [EstadoCivil, Nacionalidad],
          },
          Convocatoria,
          {
            model: Institucion,
            include: [Director, Ciudad],
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
          {
            model: Candidato,
          },
        ],
      });
      if (!carta) {
        res.status(404).json({ error: "Carta no encontrada" });
        return;
      }
      if (dato_envio === 1) {
        //Enviar Al director
        const codigo = generateRandomNumericCode(6);
        datos.fecha_envio_dir = new Date();
        datos.estado = 2;
        datos.cod_director = codigo;
        const sendToken = generarTokenAprobacion(carta.id);
        await enviarCorreo_para_Aprobacion(
          "D1r",
          carta.institucione.directore.correo,
          carta.institucione.directore.nombre,
          sendToken,
          Number(codigo)
        );
      }
      if (dato_envio === 2) {
        //Aprueba Director
        datos.fecha_apr_director = new Date();
        datos.estado = 3;
      }
      if (dato_envio === 3) {
        //Anular Carta Oferta
        datos.estado = 4;
        datos.fecha_envio_dir = null;
        datos.fecha_apr_director = null;
      }
      if (dato_envio === 4) {
        const codigo = generateRandomNumericCode(6);
        const sendToken = generarTokenAprobacion(carta.id);
        datos.cod_candidato = codigo;
        datos.fecha_envio_candidato = new Date();
        await enviarCorreo_para_Aprobacion(
          `C${carta.Candidato.id}`,
          carta.Candidato.correo,
          carta.Candidato.nombre_completo,
          sendToken,
          Number(codigo)
        );
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
    const { fecha_ingreso, horas_pactadas, esDirector, codigo } = req.body;

    try {
      const { carta_id } = validarTokenAprobacion(token);
      const carta: any = await CartaOferta.findByPk(carta_id);

      if (!carta) {
        return res.status(404).json({ mensaje: "Carta no encontrada" });
      }

      const codigoEsperado = esDirector
        ? carta.cod_director
        : carta.cod_candidato;

      console.log(
        "cod_director:",
        carta.cod_director,
        typeof carta.cod_director,
        carta.cod_director.length
      );
      console.log("codigo:", codigo);

      // Compara codigo
      if (codigoEsperado !== Number(codigo)) {
        return res.status(404).json({ mensaje: "Código inválido" });
      }

      // Construcción base del objeto de actualización
      const updateCO: Record<string, any> = esDirector
        ? {
            fecha_ingreso,
            horas_pactadas,
            fecha_apr_director: new Date(),
          }
        : {
            fecha_apr_candidato: new Date(),
          };

      // Si ya existe aprobación del otro rol, se cambia estado
      const aprobacionContraria = esDirector
        ? carta.fecha_apr_candidato
        : carta.fecha_apr_director;

      if (aprobacionContraria) {
        updateCO.estado = 3;
      }

      await carta.update(updateCO);

      return res.json({
        mensaje: "Carta aprobada correctamente",
        fechaAprobacion: new Date(),
      });
    } catch (error) {
      return res.status(401).json({ mensaje: "Token inválido o expirado" });
    }
  },
};

export default CartasOfertasController;
