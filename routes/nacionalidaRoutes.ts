import { Router } from "express";
import {
  createNacionalidad,
  deleteNacionalidad,
  getAllNacionalidades,
  getNacionalidadById,
  updateNacionalidad,
} from "../controllers/nacionalidadController";

const router = Router();

router.get("/", getAllNacionalidades);
router.get("/:id", getNacionalidadById);
router.post("/", createNacionalidad);
router.put("/:id", updateNacionalidad);
router.delete("/:id", deleteNacionalidad);

export default router;
