import { DataTypes } from "sequelize";
import db from "../BD/connection";

const EstadoCartaOferta = db.define(
  "estado_carta_oferta",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre: { type: DataTypes.STRING(50), allowNull: false },
  },
  { timestamps: false }
);
export default EstadoCartaOferta;
