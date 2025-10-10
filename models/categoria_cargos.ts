import { DataTypes } from "sequelize";
import db from "../BD/connection";

const CategoriaCargo = db.define(
  "categoriaCargo",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    nombre: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
  },
  {
    tableName: "categoria_cargos",
    timestamps: false,
  }
);
export default CategoriaCargo;
