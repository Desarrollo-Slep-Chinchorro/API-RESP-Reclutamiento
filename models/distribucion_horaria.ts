import { DataTypes } from "sequelize";
import db from "../BD/connection";

const DistribucionHoraria = db.define(
  "distribucion_horaria",
  {
    id_distribucion: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    id_solicitud: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    fuente_financiamiento: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    nivel: {
      type: DataTypes.ENUM("Basica", "Media"),
      allowNull: false,
    },
    horas: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    funcion_asignatura: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    modelName: "DistribucionHoraria",
    tableName: "distribucion_horaria",
    timestamps: false,
  }
);

export default DistribucionHoraria;
