// src/routes/candidatoRoutes.ts
import { Router } from "express";
import {
  uploadSingle,
  uploadCandidatoDocumento,
} from "../controllers/uploadController";
import {
  paramIdSchema,
  documentoCandidatoUploadSchema,
  validateParams,
  validateBody,
} from "../middleware/validatorMiddleware";

const router = Router();

// Otras rutas...

router.post(
  "/:id/documentos/upload",
  validateParams(paramIdSchema),
  uploadSingle,
  validateBody(documentoCandidatoUploadSchema),
  uploadCandidatoDocumento
);

export default router;
