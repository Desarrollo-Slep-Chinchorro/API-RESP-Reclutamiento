import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Modalidades = db.define(
  "modalidades_horarias",
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
    tableName: "modalidades_horarias",
    timestamps: false,
  }
);
export default Modalidades;
