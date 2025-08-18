import { Router } from "express";
import {
  createDocumentoCandidato,
  deleteDocumentoCandidato,
  getAllDocumentosCandidato,
  getDocumentoCandidatoById,
  updateDocumentoCandidato,
  getDocumentoCandidatoByCandidatoId,
} from "../controllers/documentoCandidatoController";

const router = Router();

router.get("/", getAllDocumentosCandidato);
router.get("/:id", getDocumentoCandidatoById);
router.get("/Candidato/:id", getDocumentoCandidatoByCandidatoId);
router.post("/", createDocumentoCandidato);
router.put("/:id", updateDocumentoCandidato);
router.delete("/:id", deleteDocumentoCandidato);

export default router;
