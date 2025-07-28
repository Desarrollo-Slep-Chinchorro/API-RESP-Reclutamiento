import { Router } from "express";
import {
  createComuna,
  deleteComuna,
  getAllComunas,
  getComunaById,
  updateComuna,
} from "../controllers/comunaController";

const router = Router();

router.get("/", getAllComunas);
router.get("/:id", getComunaById);
router.post("/", createComuna);
router.put("/:id", updateComuna);
router.delete("/:id", deleteComuna);

export default router;
