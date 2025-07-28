import { DataTypes } from "sequelize";
import db from "../BD/connection";

const Comentario = db.define(
  "comentarios",
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    candidato_id: { type: DataTypes.INTEGER, allowNull: false },
    descripcion: { type: DataTypes.TEXT, allowNull: false },
    created_at: { type: DataTypes.DATE, allowNull: false },
  },
  { timestamps: false }
);
export default Comentario;
