import { Router } from "express";
import { getAllJornadas } from "../controllers/jornadaController";

const router = Router();

router.get("/", getAllJornadas);

export default router;
