// src/models/Convocatoria.ts
import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Convocatoria = db.define(
  "Convocatoria",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    codigo: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    cargo_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    ciudad_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    institucion_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    fecha_cierre: {
      type: DataTypes.DATEONLY,
      allowNull: true,
    },
    descripcion: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    requisitos: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    estado_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    modalidad_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    tipo_vacante_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    jornada_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    categoria_cargo_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    publicada: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
  },
  {
    modelName: "Convocatoria",
    tableName: "convocatorias",
    timestamps: false,
  }
);

export default Convocatoria;
