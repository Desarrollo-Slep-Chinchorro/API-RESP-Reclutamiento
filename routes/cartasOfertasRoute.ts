// routes/cartasOfertas.ts
import { Router } from "express";
import CartasOfertasController from "../controllers/CartasOfertasController";

const router = Router();

router.get("/", CartasOfertasController.listar);
router.get("/aprobacion/:token", CartasOfertasController.obtenerCartaPorToken);
router.get("/:id", CartasOfertasController.obtenerPorId);
router.post("/aprobacion/:token", CartasOfertasController.aprobarCartaPorToken);
router.post("/", CartasOfertasController.crear);
router.put("/:id", CartasOfertasController.actualizar);
router.delete("/:id", CartasOfertasController.eliminar);

export default router;
