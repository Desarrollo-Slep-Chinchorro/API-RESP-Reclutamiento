import { Router } from "express";
import { getAllnivelEducacion } from "../controllers/nivelEducacionController";

const router = Router();

router.get("/", getAllnivelEducacion);

export default router;
