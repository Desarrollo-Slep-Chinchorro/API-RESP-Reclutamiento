import { Router } from "express";
import {
  createDocumento,
  deleteDocumento,
  getAllDocumentos,
  getDocumentoById,
  updateDocumento,
} from "../controllers/documentoController";

const router = Router();

router.get("/", getAllDocumentos);
router.get("/:id", getDocumentoById);
router.post("/", createDocumento);
router.put("/:id", updateDocumento);
router.delete("/:id", deleteDocumento);

export default router;
