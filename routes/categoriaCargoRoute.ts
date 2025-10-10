import { Router } from "express";
import { getAllCategoriaCargos } from "../controllers/categoriaCargoController";

const router = Router();

router.get("/", getAllCategoriaCargos);

export default router;
