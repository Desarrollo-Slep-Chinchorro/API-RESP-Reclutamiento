// src/routes/convocatoria.routes.ts
import { Router } from "express";
import {
  getAll,
  getById,
  createConvocatoria,
  update,
  remove,
  contarConvocatorias,
} from "../controllers/convocatoriaController";

const router = Router();

router.get("/", getAll);
router.get("/indices", contarConvocatorias);
router.get("/:id", getById);
router.post("/", createConvocatoria);
router.put("/:id", update);
router.delete("/:id", remove);

export default router;
