// utils/recuperacionUtils.ts
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";
import { Resend } from "resend";

export function generarTokenRecuperacion(usuarioId: number): string {
  return jwt.sign({ usuarioId }, process.env.JWT_SECRET!, {
    expiresIn: "15m",
  });
}

export async function enviarCorreoRecuperacion(correo: string, token: string) {
  const enlace = `${process.env.FRONTEND_URL}/restablecer-clave?token=${token}`;

  console.log("Preparando envío a:", correo);
  console.log("SMTP usuario:", process.env.MAIL_USER);
  console.log("SMTP pass:", process.env.MAIL_PASS);

  const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: process.env.MAIL_USER,
      pass: process.env.MAIL_PASS,
    },
    connectionTimeout: 10000, // 10 segundos
  });

  try {
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

    console.log("✅ Correo enviado correctamente");
  } catch (error) {
    console.error("❌ Error al enviar correo:", error);
    throw new Error("Fallo en el envío de correo");
  }
}

const resend = new Resend(process.env.RESEND_API_KEY);

export async function enviarCorreoRecuperacionResend(
  correo: string,
  token: string
) {
  const enlace = `${process.env.FRONTEND_URL}/restablecer-clave?token=${token}`;

  await resend.emails.send({
    from: "SLEP Chinchorro <noreply@slepch.gob.cl>",
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
