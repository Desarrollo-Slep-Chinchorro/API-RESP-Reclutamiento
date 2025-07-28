import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Region = db.define(
  "regiones",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre: { type: DataTypes.STRING(100), allowNull: false },
  },
  { timestamps: false }
);
export default Region;
