import { DataTypes } from "sequelize";
import db from "../BD/connection";

const CartaOferta = db.define(
  "cartas_ofertas",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    convocatoria_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    candidato_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    institucion_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    cargo_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    jornada_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    fecha_ingreso: {
      type: DataTypes.DATEONLY,
      allowNull: true,
    },
    estado: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    fecha_apr_director: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    fecha_envio_dir: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    glosa_remuneracion: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    horas_pactadas: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    fecha_apr_candidato: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    fecha_envio_candidato: {
      type: DataTypes.DATE,
      allowNull: true,
    },
  },
  {
    tableName: "cartas_ofertas",
    timestamps: false,
  }
);

export default CartaOferta;
