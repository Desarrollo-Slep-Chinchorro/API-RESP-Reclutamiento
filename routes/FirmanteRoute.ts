import { Router } from "express";
import {
  createFirmante,
  getAllFirmantes,
  getFirmanteById,
} from "../controllers/firmanteController";

const router = Router();

router.get("/", getAllFirmantes);
router.get("/:id", getFirmanteById);
router.post("/", createFirmante);
/* router.put("/:id", updateCargo);
router.delete("/:id", deleteCargo); */

export default router;
