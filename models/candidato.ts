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
    titulo_profesional_id: { type: DataTypes.INTEGER, allowNull: true },
    telefono: {
      type: DataTypes.STRING(15),
      allowNull: true,
      validate: { is: /^\+?\d{8,12}$/ },
    },
    correo: {
      type: DataTypes.STRING(100),
      allowNull: true,
      unique: true,
      validate: { isEmail: true },
    },
    estado_candidato_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 1,
    },
    nacionalidad_id: { type: DataTypes.INTEGER, allowNull: true },
    estado_civil_id: { type: DataTypes.INTEGER, allowNull: true },
    direccion: { type: DataTypes.STRING(255), allowNull: true },
    comuna_id: { type: DataTypes.INTEGER, allowNull: true },
    usuario_id: { type: DataTypes.INTEGER, allowNull: false },
    fecha_nacimiento: { type: DataTypes.DATE, allowNull: true },
    presentacion: { type: DataTypes.STRING(1000), allowNull: true },
    tipo_vacante_nuevo: { type: DataTypes.BOOLEAN, allowNull: true },
    tipo_vacante_reemplazo: { type: DataTypes.BOOLEAN, allowNull: true },
    categoria_funcionaria_id: { type: DataTypes.INTEGER, allowNull: true },
    nivel_educacion_id: { type: DataTypes.INTEGER, allowNull: true },
    especialidad: { type: DataTypes.STRING(100), allowNull: true },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW, // Añade defaultValue
    },
  },
  {
    sequelize: db,
    tableName: "candidatos",
    timestamps: false,
    hooks: {
      beforeUpdate: async (instance: Candidato) => {
        await db.query("SELECT public.update_modified_column()");
        // También actualiza manualmente el campo
        instance.updated_at = new Date();
      },
    },
  }
);
export default Candidato;
