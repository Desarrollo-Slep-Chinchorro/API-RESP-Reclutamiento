import { DataTypes } from "sequelize";
import db from "../BD/connection";

const CandidatosModalidades = db.define(
  "candidatos_modalidades",
  {
    candidato_id: { type: DataTypes.INTEGER, primaryKey: true },
    modalidad_horaria_id: { type: DataTypes.INTEGER, primaryKey: true },
  },
  { timestamps: false }
);
export default CandidatosModalidades;
