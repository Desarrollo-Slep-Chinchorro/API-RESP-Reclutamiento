import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Ciudad = db.define(
  "mensajes",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    nombre: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    correo: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    mensaje: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    rut: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    estado: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true,
    },
  },
  {
    tableName: "mensajes",
    timestamps: false,
  }
);
export default Ciudad;
