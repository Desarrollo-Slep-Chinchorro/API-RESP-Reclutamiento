import { DataTypes } from "sequelize";
import db from "../BD/connection";

const DocumentoCandidato = db.define(
  "documentos_candidatos",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    documento_id: { type: DataTypes.INTEGER, allowNull: false },
    candidato_id: { type: DataTypes.INTEGER, allowNull: false },
    ruta: { type: DataTypes.STRING(255), allowNull: false },
    nombre: { type: DataTypes.STRING(255), allowNull: false },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
  },
  { timestamps: false }
);
export default DocumentoCandidato;
