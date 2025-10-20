import { Request, Response } from "express";
import DocumentoCandidato from "../models/documentos_candidato";
import Documento from "../models/documento";

export const getAllDocumentosCandidato = async (
  _req: Request,
  res: Response
) => {
  try {
    const docsCand = await DocumentoCandidato.findAll();
    res.json(docsCand);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener documentos de candidato", error });
    return;
  }
};

export const getDocumentoCandidatoById = async (
  req: Request,
  res: Response
) => {
  const { id } = req.params;
  try {
    const docCand = await DocumentoCandidato.findByPk(id);
    if (!docCand) {
      res.status(404).json({ message: "Documento de candidato no encontrado" });
      return;
    }
    res.json(docCand);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener documento de candidato", error });
    return;
  }
};

export const getDocumentoCandidatoByCandidatoId = async (
  req: Request,
  res: Response
) => {
  const { id } = req.params;
  try {
    const docCand = await DocumentoCandidato.findAll({
      where: {
        candidato_id: id,
      },
    });
    if (!docCand) {
      res.status(404).json({ message: "Documento de candidato no encontrado" });
      return;
    }
    res.json(docCand);
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al obtener documento de candidato", error });
    return;
  }
};

export const createDocumentoCandidato = async (req: Request, res: Response) => {
  try {
    const newDocCand = await DocumentoCandidato.create(req.body);
    res.status(201).json(newDocCand);
    return;
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error al crear documento de candidato", error });
    return;
  }
};

export const updateDocumentoCandidato = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const [updated] = await DocumentoCandidato.update(req.body, {
      where: { id },
    });
    if (!updated) {
      res.status(404).json({ message: "Documento de candidato no encontrado" });
      return;
    }
    const updatedDocCand = await DocumentoCandidato.findByPk(id);
    res.json(updatedDocCand);
    return;
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error al actualizar documento de candidato", error });
    return;
  }
};

export const deleteDocumentoCandidato = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const deleted = await DocumentoCandidato.destroy({ where: { id } });
    if (!deleted) {
      res.status(404).json({ message: "Documento de candidato no encontrado" });
      return;
    }
    res.json({ message: "Documento de candidato eliminado" });
    return;
  } catch (error) {
    res
      .status(500)
      .json({ message: "Error al eliminar documento de candidato", error });
    return;
  }
};

export const documentosFaltantesPorFase = async (
  req: Request,
  res: Response
) => {
  const candidatoId = parseInt(req.params.id);
  const fase = parseInt(req.params.fase);

  if (isNaN(candidatoId) || isNaN(fase)) {
    return res.status(400).json({ error: "Parámetros inválidos" });
  }

  try {
    // 1. Obtener todos los documentos requeridos en la fase
    const requeridos = await Documento.findAll({
      where: { fase_candidato: fase },
      attributes: ["id", "nombre"],
    });

    // 2. Obtener todos los documentos que el candidato ya cargó
    const cargados = await DocumentoCandidato.findAll({
      where: { candidato_id: candidatoId },
      attributes: ["documento_id"],
    });

    const idsCargados = cargados.map((doc: any) => doc.documento_id);

    // 3. Filtrar los que faltan
    const faltantes = requeridos.filter(
      (doc: any) => !idsCargados.includes(doc.id)
    );

    return res.json({
      candidato_id: candidatoId,
      fase,
      faltantes,
      total_faltantes: faltantes.length,
    });
  } catch (error) {
    console.error("Error al obtener documentos faltantes:", error);
    return res.status(500).json({ error: "Error interno del servidor" });
  }
};
