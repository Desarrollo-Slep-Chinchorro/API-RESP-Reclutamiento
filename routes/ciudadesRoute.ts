import { Router } from "express";
import { getAllCiudades } from "../controllers/ciudadesController";

const router = Router();

router.get("/", getAllCiudades);

export default router;
