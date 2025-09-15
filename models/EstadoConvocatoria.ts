import { DataTypes } from "sequelize";
import db from "../BD/connection";

const EstadoConvocatoria = db.define(
  "estado_convocatoria",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    nombre: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    modelName: "EstadoConvocatoria",
    tableName: "estado_convocatoria",
    timestamps: false,
  }
);
export default EstadoConvocatoria;
