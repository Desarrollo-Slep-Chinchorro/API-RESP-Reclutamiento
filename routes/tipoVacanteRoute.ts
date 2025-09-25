import { Router } from "express";
import { getAllJornadas } from "../controllers/jornadaController";
import { getAllTipo_vacantes } from "../controllers/tipoVacanteController";

const router = Router();

router.get("/", getAllTipo_vacantes);

export default router;
