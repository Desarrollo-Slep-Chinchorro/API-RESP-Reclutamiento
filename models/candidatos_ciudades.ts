import { DataTypes } from "sequelize";
import db from "../BD/connection";

const CandidatosCiudades = db.define(
  "candidatos_ciudades",
  {
    candidato_id: { type: DataTypes.INTEGER, primaryKey: true },
    ciudades_id: { type: DataTypes.INTEGER, primaryKey: true },
  },
  { timestamps: false }
);
export default CandidatosCiudades;
