import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Reemplazo = db.define(
  "reemplazos",
  {
    id_reemplazo: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    id_solicitud: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    rut_reemplazado: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    nombre_reemplazado: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    motivo_reemplazo: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    fecha_inicio_reemplazo: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
    fecha_termino_reemplazo: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
  },
  {
    modelName: "Reemplazo",
    tableName: "reemplazos",
    timestamps: false,
  }
);

export default Reemplazo;
