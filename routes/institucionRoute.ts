import { Router } from "express";
import {
  getAllInstituciones,
  getInstitucionById,
} from "../controllers/institucionesController";

const router = Router();

router.get("/", getAllInstituciones);
router.get("/:id", getInstitucionById);

export default router;
