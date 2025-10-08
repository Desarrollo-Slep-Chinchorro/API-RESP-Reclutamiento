// utils/recuperacionUtils.ts
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";

export function generarTokenRecuperacion(usuarioId: number): string {
  return jwt.sign({ usuarioId }, process.env.JWT_SECRET!, {
    expiresIn: "15m",
  });
}

export async function enviarCorreoRecuperacion(correo: string, token: string) {
  const enlace = `${process.env.FRONTEND_URL}/restablecer-clave?token=${token}`;

  const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: process.env.MAIL_USER,
      pass: process.env.MAIL_PASS,
    },
  });

  await transporter.sendMail({
    from: `"SLEP Chinchorro" <${process.env.MAIL_USER}>`,
    to: correo,
    subject: "Recuperación de contraseña",
    html: `
      <p>Hola,</p>
      <p>Haz clic en el siguiente enlace para restablecer tu contraseña:</p>
      <a href="${enlace}">${enlace}</a>
      <p>Este enlace expirará en 15 minutos.</p>
    `,
  });
}
