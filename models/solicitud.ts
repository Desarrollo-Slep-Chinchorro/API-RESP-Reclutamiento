import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Solicitud = db.define(
  "solicitudes",
  {
    id_solicitud: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    folio: {
      type: DataTypes.INTEGER,
      allowNull: false,
      unique: true,
    },
    establecimiento: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    fecha_solicitud: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    enviado_por: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    cargo_solicitado: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    asignatura: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    subvencion: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    estatuto: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    tipo_jornada: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    fecha_seleccion: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
    tipo_solicitud: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    requisitos: {
      type: DataTypes.TEXT,
    },
    otras_observaciones: {
      type: DataTypes.TEXT,
    },
  },
  {
    modelName: "Solicitud",
    tableName: "solicitudes",
    timestamps: false,
  }
);

export default Solicitud;
