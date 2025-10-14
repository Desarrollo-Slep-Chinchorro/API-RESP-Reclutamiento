import { Router } from "express";
import {
  agrupadasPorConvocatoriaEstadoAsc,
  crearPostulacion,
  listarPostulaciones,
} from "../controllers/postulacionController";

const router = Router();

router.post("/", crearPostulacion);
router.get("/", listarPostulaciones);
router.get("/agrupadas/:estado", agrupadasPorConvocatoriaEstadoAsc);

export default router;
