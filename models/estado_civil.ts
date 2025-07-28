import { DataTypes } from "sequelize";
import db from "../BD/connection";

const EstadoCivil = db.define(
  "estados_civiles",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre: { type: DataTypes.STRING(50), allowNull: false },
  },
  { timestamps: false }
);
export default EstadoCivil;
