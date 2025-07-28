import { Router } from "express";
import {
  createCandidatoCargo,
  deleteCandidatoCargo,
  getAllCandidatosCargos,
} from "../controllers/candidatosCargoController";

const router = Router();

router.get("/", getAllCandidatosCargos);
/* router.get("/:id", getCand); */
router.post("/", createCandidatoCargo);
/* router.put("/:id", ); */
router.delete("/:id", deleteCandidatoCargo);

export default router;
