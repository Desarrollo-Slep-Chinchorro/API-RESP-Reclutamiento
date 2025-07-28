import { DataTypes } from "sequelize";
import db from "../BD/connection";

const DocumentoCandidato = db.define(
  "documentos_candidatos",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    documento_id: { type: DataTypes.INTEGER, allowNull: false },
    candidato_id: { type: DataTypes.INTEGER, allowNull: false },
    ruta: { type: DataTypes.STRING(255), allowNull: false },
  },
  { timestamps: false }
);
export default DocumentoCandidato;
