import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Ciudad = db.define(
  "ciudades",
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
    modelName: "Ciudad",
    tableName: "ciudades",
    timestamps: false,
  }
);
export default Ciudad;
