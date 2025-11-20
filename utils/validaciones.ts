// utils/recuperacionUtils.ts
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";
import { Resend } from "resend";

export function generarTokenRecuperacion(usuarioId: number): string {
  return jwt.sign({ usuarioId }, process.env.JWT_SECRET!, {
    expiresIn: "15m",
  });
}

export function generarTokenAprobacion(carta_id: number): string {
  return jwt.sign({ carta_id }, process.env.JWT_SECRET!, {
    expiresIn: "2d",
  });
}

export function validarTokenAprobacion(token: string): any {
  try {
    console.log("Validando token de aprobación:", token);
    const payload = jwt.verify(token, process.env.JWT_SECRET!);
    return payload;
  } catch (error) {
    console.error("Error al validar token de aprobación:", error);
    return null;
  }
}

async function transport() {
  return nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: process.env.MAIL_USER,
      pass: process.env.MAIL_PASS,
    },
    connectionTimeout: 10000, // 10 segundos
  });
}

export async function enviarCorreoRecuperacion(correo: string, token: string) {
  const enlace = `${process.env.FRONTEND_URL}/restablecer-clave?token=${token}`;

  console.log("Preparando envío a:", correo);
  console.log("SMTP usuario:", process.env.MAIL_USER);
  console.log("SMTP pass:", process.env.MAIL_PASS);

  const transporter = await transport();

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

export const enviarCorreo_para_Aprobacion = async (
  director: string,
  destinatario_correo: string,
  destinatario_nombre: string,
  token: string
) => {
  const enlace = `${process.env.FRONTEND_URL}/aprobar-carta?alt=${director}&token=${token}`;

  const transporter = await transport();

  await transporter.sendMail({
    from: '"SLEP Chinchorro" <no-reply@slepchinchorro.cl>',
    to: destinatario_correo,
    subject: "Carta Oferta - Necesita su aprobación",
    html: `
      <p>Estimada/o ${destinatario_nombre},</p>
      <p>Se ha generado una carta oferta para su revisión y aprobación.</p>
      <p>NOTA: Este enlace estará disponible solo por 48 hrs. corridas a partir de la fecha de emisión de este correo.</p>
      <p><a href="${enlace}">Haga clic aquí para aprobar la carta</a></p>
    `,
  });

  console.log("Correo enviado correctamente");
};

export async function enviarCorreoRecuperacionResend(
  correo: string,
  token: string
) {
  const resend = new Resend(process.env.RESEND_API_KEY);
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
