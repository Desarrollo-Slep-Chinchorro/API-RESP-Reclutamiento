import { Router } from "express";
import {
  createRegion,
  deleteRegion,
  getAllRegions,
  getRegionById,
  updateRegion,
} from "../controllers/regionController";

const router = Router();

router.get("/", getAllRegions);
router.get("/:id", getRegionById);
router.post("/", createRegion);
router.put("/:id", updateRegion);
router.delete("/:id", deleteRegion);

export default router;
