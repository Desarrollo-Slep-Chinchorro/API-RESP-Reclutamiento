import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Nacionalidad = db.define(
  "nacionalidades",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre: { type: DataTypes.STRING(50), allowNull: false },
  },
  { timestamps: false }
);
export default Nacionalidad;
