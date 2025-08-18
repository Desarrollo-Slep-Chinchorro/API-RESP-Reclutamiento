// src/routes/candidatoRoutes.ts
import { Router } from "express";
import {
  uploadSingle,
  uploadCandidatoDocumento,
} from "../controllers/uploadDocumentoCandidatoController";
import {
  paramIdSchema,
  documentoCandidatoUploadSchema,
  validateParams,
  validateBody,
} from "../middleware/validatorMiddleware";

const router = Router();

// Otras rutas...

router.post("/", uploadCandidatoDocumento);

export default router;
