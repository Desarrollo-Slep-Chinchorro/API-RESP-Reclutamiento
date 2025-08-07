import { DataTypes, Model } from "sequelize";
import db from "../BD/connection";

class Candidato extends Model {
  public id!: number;
  public rut!: string;
  public nombre_completo!: string;
  public titulo_profesional_id!: number;
  public telefono!: string;
  public correo!: string;
  public estado_candidato_id!: number;
  public nacionalidad_id!: number;
  public estado_civil_id!: number;
  public direccion!: string;
  public comuna_id!: number;
  public created_at!: Date;
  public updated_at!: Date;
}

Candidato.init(
  {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    rut: {
      type: DataTypes.STRING(12),
      allowNull: false,
      validate: { is: /^\d{7,8}-[\dkK]$/ },
    },
    nombre_completo: { type: DataTypes.STRING(100), allowNull: false },
    titulo_profesional_id: { type: DataTypes.INTEGER, allowNull: false },
    telefono: {
      type: DataTypes.STRING(15),
      allowNull: false,
      validate: { is: /^\+?\d{8,12}$/ },
    },
    correo: {
      type: DataTypes.STRING(100),
      allowNull: false,
      unique: true,
      validate: { isEmail: true },
    },
    estado_candidato_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1,
    },
    nacionalidad_id: { type: DataTypes.INTEGER, allowNull: false },
    estado_civil_id: { type: DataTypes.INTEGER, allowNull: false },
    direccion: { type: DataTypes.STRING(255), allowNull: false },
    comuna_id: { type: DataTypes.INTEGER, allowNull: false },
    usuario_id: { type: DataTypes.INTEGER, allowNull: false },
    created_at: { type: DataTypes.DATE, allowNull: false },
    updated_at: { type: DataTypes.DATE, allowNull: false },
  },
  {
    sequelize: db,
    tableName: "candidatos",
    timestamps: false,
    hooks: {
      beforeUpdate: async (instance: Candidato) => {
        await db.query("SELECT public.update_modified_column()");
      },
    },
  }
);

export default Candidato;
