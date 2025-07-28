import { DataTypes } from "sequelize";
import db from "../BD/connection";

const CandidatosCargos = db.define(
  "candidatos_cargos",
  {
    candidato_id: { type: DataTypes.INTEGER, primaryKey: true },
    cargo_id: { type: DataTypes.INTEGER, primaryKey: true },
  },
  { timestamps: false }
);
export default CandidatosCargos;
