import { Router } from "express";
import {
  agrupadasPorConvocatoriaEstadoAsc,
  crearPostulacion,
  listarPostulaciones,
  updatePostulacionCandidato,
} from "../controllers/postulacionController";

const router = Router();

router.post("/", crearPostulacion);
router.get("/", listarPostulaciones);
router.put("/candidato/:id", updatePostulacionCandidato);
router.get("/agrupadas/:estado", agrupadasPorConvocatoriaEstadoAsc);

export default router;
