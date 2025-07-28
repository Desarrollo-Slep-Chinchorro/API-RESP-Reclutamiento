import { Router } from "express";
import {
  createCargo,
  deleteCargo,
  getAllCargos,
  getCargoById,
  updateCargo,
} from "../controllers/cargoController";

const router = Router();

router.get("/", getAllCargos);
router.get("/:id", getCargoById);
router.post("/", createCargo);
router.put("/:id", updateCargo);
router.delete("/:id", deleteCargo);

export default router;
