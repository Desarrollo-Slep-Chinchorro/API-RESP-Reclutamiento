import { DataTypes } from "sequelize";
import db from "../BD/connection";

const tipoVacante = db.define(
  "tipo_vacante",
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
    timestamps: false,
  }
);

export default tipoVacante;
