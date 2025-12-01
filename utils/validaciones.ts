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
  token: string,
  codigo: number
) => {
  const enlace = `${process.env.FRONTEND_URL}/aprobar-carta?alt=${director}&token=${token}`;

  const transporter = await transport();

  await transporter.sendMail({
    from: '"SLEP Chinchorro" <no-reply@slepchinchorro.cl>',
    to: destinatario_correo,
    subject: "Carta Oferta - Necesita su aprobación",
    html: `
     <div style="width:100%; background:#f4f6f8; padding:20px 0;">
    <div style="max-width:600px; margin:0 auto; background:#ffffff; border:1px solid #e5e7eb;">
      
      <!-- Encabezado -->
      <div style="background:#0b4ea2; color:#ffffff; font-size:18px; font-weight:bold; padding:16px 20px;">
        Carta oferta – Revisión y aprobación
      </div>

      <!-- Contenido -->
      <div style="padding:20px; color:#111827; font-size:14px; line-height:1.6;">
        <p>Estimado/a <strong>${destinatario_nombre}</strong>,</p>
        <p>Se ha generado una carta oferta que requiere su revisión, confirmar la fecha de ingreso y su aprobación.</p>

        <!-- Código -->
        <div style="color:#374151; font-weight:bold; margin:16px 0 6px;">Código de aprobación:</div>
        <div style="font-family:'Courier New', monospace; font-size:22px; letter-spacing:4px; background:#f3f4f6; border:1px solid #d1d5db; border-radius:6px; padding:14px 18px; display:inline-block;">
          ${codigo}
        </div>

        <!-- Nota -->
        <div style="margin-top:16px; padding:12px 14px; background:#f9fafb; border-left:4px solid #0b4ea2; color:#374151; font-size:13px;">
          <strong>Nota:</strong> Este enlace estará disponible únicamente durante <strong>48 horas corridas</strong> a partir de la fecha de emisión de este correo.
        </div>

        <!-- Botón -->
        <div style="margin:22px 0;">
          <a href="${enlace}" target="_blank" rel="noopener" 
             style="display:inline-block; background:#0b4ea2; color:#ffffff; text-decoration:none; padding:12px 18px; border-radius:6px; font-weight:bold;">
            Haga clic aquí para aprobar la carta
          </a>
        </div>
      </div>

      <!-- Pie -->
      <div style="padding:14px 20px; font-size:12px; color:#6b7280; border-top:1px solid #e5e7eb;">
        Sistema Institucional SDGP – SLEP Chinchorro
      </div>
    </div>
  </div>
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

export function generateRandomNumericCode(length: number = 6): string {
  if (length <= 0) {
    throw new Error("La longitud debe ser mayor a 0");
  }

  let result = "";
  for (let i = 0; i < length; i++) {
    const digit = Math.floor(Math.random() * 10); // número entre 0 y 9
    result += digit.toString();
  }
  return result;
}
