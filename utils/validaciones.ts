// utils/recuperacionUtils.ts
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.MAIL_USER, // ej: slepchinchorro@gmail.com
    pass: process.env.MAIL_PASS, // contraseña o app password
  },
});

export function generarTokenRecuperacion(candidatoId: number): string {
  return jwt.sign({ candidatoId }, process.env.JWT_SECRET!, {
    expiresIn: "15m",
  });
}

// utils/recuperacionUtils.ts
export async function enviarCorreoRecuperacion(correo: string, token: string) {
  const enlace = `${process.env.FRONTEND_URL}/restablecer-clave?token=${token}`;

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
