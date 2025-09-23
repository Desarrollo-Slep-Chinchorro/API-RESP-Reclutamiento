import { DataTypes } from "sequelize";
import db from "../BD/connection";

const nivelEducacion = db.define(
  "nivel_educacion",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre: { type: DataTypes.STRING(100), allowNull: false },
  },
  {
    tableName: "nivel_educacion",
    timestamps: false,
  }
);
export default nivelEducacion;
