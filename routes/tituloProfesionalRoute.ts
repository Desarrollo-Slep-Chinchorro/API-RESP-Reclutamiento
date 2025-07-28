import { Router } from "express";
import {
  createTituloProfesional,
  deleteTituloProfesional,
  getAllTitulosProfesionales,
  getTituloProfesionalById,
  updateTituloProfesional,
} from "../controllers/tituloProfesionalController";

const router = Router();

router.get("/", getAllTitulosProfesionales);
router.get("/:id", getTituloProfesionalById);
router.post("/", createTituloProfesional);
router.put("/:id", updateTituloProfesional);
router.delete("/:id", deleteTituloProfesional);

export default router;
