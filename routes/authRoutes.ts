import { Router } from "express";
import { verifyToken, checkRole } from "../middleware/authMiddleware";
import {
  login,
  getProfile,
  registerCandidate,
  recuperarClave,
} from "../controllers/authController";

const router = Router();

router.post("/login", login);
router.get("/profile", verifyToken, getProfile);
router.post("/recuperar-clave", recuperarClave);
router.post("/register", registerCandidate);

// Ejemplo de ruta protegida con rol específico
router.get("/admin", verifyToken, checkRole(["admin"]), (req, res) => {
  res.json({ message: "Acceso concedido para administradores" });
});

export default router;
