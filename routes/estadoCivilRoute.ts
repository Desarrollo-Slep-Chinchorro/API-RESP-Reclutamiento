import { Router } from "express";
import {
  createEstadoCivil,
  deleteEstadoCivil,
  getAllEstadosCiviles,
  getEstadoCivilById,
  updateEstadoCivil,
} from "../controllers/estadoCivilController";

const router = Router();

router.get("/", getAllEstadosCiviles);
router.get("/:id", getEstadoCivilById);
router.post("/", createEstadoCivil);
router.put("/:id", updateEstadoCivil);
router.delete("/:id", deleteEstadoCivil);

export default router;
