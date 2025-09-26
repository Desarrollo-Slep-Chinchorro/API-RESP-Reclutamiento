// models/Postulacion.ts
import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Postulacion = db.define(
  "Postulacion",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    candidato_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "Candidatos",
        key: "id",
      },
    },
    convocatoria_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "Convocatorias",
        key: "id",
      },
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
  },
  {
    tableName: "postulaciones",
    timestamps: false,
  }
);

export default Postulacion;
