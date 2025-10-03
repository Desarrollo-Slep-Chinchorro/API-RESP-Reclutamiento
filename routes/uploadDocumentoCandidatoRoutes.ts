// src/routes/candidatoRoutes.ts
import { Router } from "express";
import {
  deleteFile,
  uploadCandidatoDocumento,
  viewFiles,
} from "../controllers/uploadDocumentoCandidatoController";
import { uploadMiddleware } from "../middleware/validatorMiddleware";

const router = Router();

// Otras rutas...

router.post("/", uploadMiddleware, uploadCandidatoDocumento);
router.get("/file/:id", viewFiles);
router.delete("/:id", deleteFile);

export default router;
