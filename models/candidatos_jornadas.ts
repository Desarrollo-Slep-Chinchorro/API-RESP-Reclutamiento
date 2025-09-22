import { DataTypes } from "sequelize";
import db from "../BD/connection";

const CandidatosJornadas = db.define(
  "candidatos_jornadas",
  {
    candidato_id: { type: DataTypes.INTEGER, primaryKey: true },
    jornada_id: { type: DataTypes.INTEGER, primaryKey: true },
  },
  { timestamps: false }
);
export default CandidatosJornadas;
