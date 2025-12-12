import { DataTypes } from "sequelize";
import db from "../BD/connection";

const TotalesDistribucion = db.define(
  "totales_distribucion",
  {
    id_total: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    id_solicitud: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    total_horas_basica: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
    },
    total_horas_media: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
    },
    total_horas: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
    },
  },
  {
    modelName: "TotalesDistribucion",
    tableName: "totales_distribucion",
    timestamps: false,
  }
);

export default TotalesDistribucion;
