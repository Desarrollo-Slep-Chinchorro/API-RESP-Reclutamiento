import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Firmantes = db.define(
  "firmante",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre: { type: DataTypes.STRING(100), allowNull: false },
    rut: { type: DataTypes.STRING(12), allowNull: false },
    rex: { type: DataTypes.STRING(40), allowNull: false },
    cargo: { type: DataTypes.STRING(50), allowNull: false },
  },
  { timestamps: false }
);
export default Firmantes;
