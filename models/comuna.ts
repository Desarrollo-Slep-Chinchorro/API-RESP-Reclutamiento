import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Comuna = db.define(
  "comunas",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre: { type: DataTypes.STRING(100), allowNull: false },
    region_id: { type: DataTypes.INTEGER, allowNull: false },
  },
  { timestamps: false }
);
export default Comuna;
