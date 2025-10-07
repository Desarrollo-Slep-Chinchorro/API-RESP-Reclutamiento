import nodemailer from "nodemailer";
import dotenv from "dotenv";

dotenv.config();

async function enviarCorreoPrueba() {
  const transporter = nodemailer.createTransport({
    service: "gmail", // puedes cambiar a otro proveedor si usas institucional
    auth: {
      user: process.env.MAIL_USER,
      pass: process.env.MAIL_PASS,
    },
  });

  try {
    const info = await transporter.sendMail({
      from: `"SLEP Chinchorro" <${process.env.MAIL_USER}>`,
      to: "tucorreo@dominio.cl", // reemplaza por tu correo de prueba
      subject: "📧 Prueba de envío institucional",
      html: `
        <h3>Correo de prueba</h3>
        <p>Este mensaje confirma que el servidor de correo está funcionando correctamente.</p>
      `,
    });

    console.log("✅ Correo enviado:", info.messageId);
  } catch (error) {
    console.error("❌ Error al enviar correo:", error);
  }
}

enviarCorreoPrueba();
