import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Jornada = db.define(
  "jornadas",
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
    tableName: "jornadas",
    timestamps: false,
  }
);
export default Jornada;
