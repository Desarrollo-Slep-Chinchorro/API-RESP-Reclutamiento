import { Request, Response } from "express";
import nodemailer from "nodemailer";
import Mensaje from "../models/mensaje";

export const sendInstitutionalEmail = async (
  name: string,
  email: string,
  message: string,
  rut: string
): Promise<void> => {
  const transporter = nodemailer.createTransport({
    /*     service: "gmail",
    auth: {
      user: process.env.MAIL_USER,
      pass: process.env.MAIL_PASS, // usa dotenv, no hardcodees
    }, */
    host: "sandbox.smtp.mailtrap.io",
    port: 2525,
    auth: {
      user: "michael.aguirre.saavedra@gmail.com",
      pass: "M14gs4@#",
    },
  });

  // Verifica conexión SMTP antes de enviar
  await transporter
    .verify()
    .then(() => {
      console.log("✅ Conexión SMTP exitosa");
    })
    .catch((error) => {
      console.error("🚫 Error SMTP:", error);
      throw error; // Propaga el error para que el controlador lo capture
    });

  // Si la verificación fue exitosa, intenta enviar
  await transporter.sendMail({
    from: `"${name}" <${email}>`,
    to: "michael.aguirre@epchinchorro.cl",
    subject: "📩 Nuevo mensaje Formulario Web",
    html: `
      <div style="font-family:sans-serif;">
        <h2>Mensaje desde formulario institucional</h2>
        <p><strong>Nombre:</strong> ${name}</p>
        <p><strong>Rut:</strong> ${rut}</p>
        <p><strong>Correo:</strong> ${email}</p>
        <p><strong>Mensaje:</strong><br>${message}</p>
        <hr>
        <small>Este correo fue generado automáticamente desde la plataforma institucional.</small>
      </div>
    `,
  });
};

export const createMensaje = async (req: Request, res: Response) => {
  try {
    const { name, email, mensaje, rut } = req.body;

    //const newMensaje = await Mensaje.create(req.body);
    await sendInstitutionalEmail(name, email, mensaje, rut);
    res.status(200).json({ success: true });
    //res.status(201).json(newMensaje);
  } catch (error) {
    res.status(400).json({ mensaje: "Error al crear mensaje", error });
  }
};

export const getAllMensajes = async (req: Request, res: Response) => {
  try {
    const mensajes = await Mensaje.findAll();
    res.json(mensajes);
  } catch (error) {
    res.status(500).json({ message: "Error al obtener mensajes", error });
  }
};
