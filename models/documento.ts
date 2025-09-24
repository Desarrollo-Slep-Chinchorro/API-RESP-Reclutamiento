import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Documento = db.define(
  "documentos",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre: { type: DataTypes.STRING(100), allowNull: false },
    fase_candidato: { type: DataTypes.INTEGER, allowNull: false },
  },
  { timestamps: false }
);
export default Documento;
