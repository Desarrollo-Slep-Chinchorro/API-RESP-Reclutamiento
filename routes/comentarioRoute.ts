import { Router } from "express";
import {
  createComentario,
  deleteComentario,
  getAllComentarios,
  getComentarioById,
  updateComentario,
} from "../controllers/comentarioController";

const router = Router();

router.get("/", getAllComentarios);
router.get("/:id", getComentarioById);
router.post("/", createComentario);
router.put("/:id", updateComentario);
router.delete("/:id", deleteComentario);

export default router;
