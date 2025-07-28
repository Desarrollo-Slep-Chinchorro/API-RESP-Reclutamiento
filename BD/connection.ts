import { Sequelize } from "sequelize";

const BD_HOST: string = process.env.BD_HOST || "localhost";
const BD_NAME: string = process.env.BD_NAME || "Reclutamiento_BD";
const BD_USERNAME: string = process.env.BD_USERNAME || "postgres";
const BD_PASSWORD: string = process.env.BD_PASSWORD || "root2025";
const BD_PORT: number = Number(process.env.BD_PORT) || 5432;

//BASE DE DATOS LOCAL
const db = new Sequelize(BD_NAME, BD_USERNAME, BD_PASSWORD, {
  host: BD_HOST,
  dialect: "postgres",
  port: BD_PORT,
  define: {
    // Solo habilitar timestamps globalmente
    timestamps: false, // Activar los campos createdAt y updatedAt por defecto
  },
  timezone: "America/Santiago", // Establecer la zona horaria
});

export default db;
