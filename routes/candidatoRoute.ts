import { Router } from "express";
import {
  createCandidato,
  deleteCandidato,
  getAllCandidatos,
  getCandidatoById,
  updateCandidato,
  actualizarEstadoCandidato,
} from "../controllers/candidatoController";

const router = Router();

router.get("/", getAllCandidatos);
router.get("/:id", getCandidatoById);
router.post("/", createCandidato);
router.put("/:id/estado", actualizarEstadoCandidato);
router.put("/:id", updateCandidato);
router.delete("/:id", deleteCandidato);

export default router;
