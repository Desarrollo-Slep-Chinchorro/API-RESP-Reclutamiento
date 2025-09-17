import { Router } from "express";
import {
  getAllMensajes,
  createMensaje,
} from "../controllers/mensajeController";

const router = Router();
router.get("/", getAllMensajes);
router.post("/", createMensaje);

export default router;
