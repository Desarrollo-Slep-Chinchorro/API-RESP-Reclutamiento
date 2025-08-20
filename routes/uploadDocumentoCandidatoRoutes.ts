// src/routes/candidatoRoutes.ts
import { Router } from "express";
import {
  deleteFile,
  uploadCandidatoDocumento,
  viewFiles,
} from "../controllers/uploadDocumentoCandidatoController";
import { uploadMemory } from "../middleware/validatorMiddleware";

const router = Router();

// Otras rutas...

router.post("/", uploadMemory, uploadCandidatoDocumento);
router.get("/file/:id", viewFiles);
router.delete("/:id", deleteFile);

export default router;
