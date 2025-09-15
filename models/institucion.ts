import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Institucion = db.define(
  "instituciones",
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
    tableName: "instituciones",
    timestamps: false,
  }
);

export default Institucion;
