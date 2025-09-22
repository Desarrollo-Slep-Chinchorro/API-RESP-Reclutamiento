import { Router } from "express";
import { getAllModalidades } from "../controllers/modalidadesController";

const router = Router();

router.get("/", getAllModalidades);

export default router;
