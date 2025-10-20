import { Router } from "express";
import {
  createDocumentoCandidato,
  deleteDocumentoCandidato,
  getAllDocumentosCandidato,
  getDocumentoCandidatoById,
  updateDocumentoCandidato,
  getDocumentoCandidatoByCandidatoId,
  documentosFaltantesPorFase,
} from "../controllers/documentoCandidatoController";

const router = Router();

router.get("/", getAllDocumentosCandidato);
router.get("/candidato/:id/faltantes/fase/:fase", documentosFaltantesPorFase);
router.get("/:id", getDocumentoCandidatoById);
router.get("/Candidato/:id", getDocumentoCandidatoByCandidatoId);
router.post("/", createDocumentoCandidato);
router.put("/:id", updateDocumentoCandidato);
router.delete("/:id", deleteDocumentoCandidato);

export default router;
