import { Router } from "express";
import {
  createEstadoCandidato,
  deleteEstadoCandidato,
  getAllEstadoCandidatos,
  getEstadoCandidatoById,
  updateEstadoCandidato,
} from "../controllers/estadoCandidatoController";

const router = Router();

router.get("/", getAllEstadoCandidatos);
router.get("/:id", getEstadoCandidatoById);
router.post("/", createEstadoCandidato);
router.put("/:id", updateEstadoCandidato);
router.delete("/:id", deleteEstadoCandidato);

export default router;
