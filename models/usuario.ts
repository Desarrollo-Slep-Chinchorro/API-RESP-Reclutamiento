import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Usuario = db.define(
  "usuarios",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    usuario: { type: DataTypes.STRING(100), allowNull: false },
    password: { type: DataTypes.STRING(100), allowNull: false },
    estado: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: true },
    rol: { type: DataTypes.STRING(50), allowNull: false, defaultValue: "user" }, // Default role is 'user'
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
  },
  { timestamps: false }
);
export default Usuario;
