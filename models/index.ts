import db from "../BD/connection";
import Candidato from "./candidato";
import Cargo from "./cargo";
import CandidatosCargos from "./candidatos_cargos";
import Comentario from "./comentario";
import Comuna from "./comuna";
import Region from "./region";
import Documento from "./documento";
import DocumentoCandidato from "./documentos_candidato";
import EstadoCandidato from "./estado_candidato";
import EstadoCivil from "./estado_civil";
import Nacionalidad from "./nacionalidad";
import TituloProfesional from "./titulo_profesional";
import Usuario from "./usuario";
import Institucion from "./institucion";
import Ciudad from "./ciudad";
import EstadoConvocatoria from "./EstadoConvocatoria";
import Convocatoria from "./convocatoria";
import Jornada from "./jornada";
import CandidatosJornadas from "./candidatos_jornadas";
import CandidatosCiudades from "./candidatos_ciudades";
import Modalidades from "./modalidad";
import CandidatosModalidades from "./candidatos_modalidades";

// Relaciones candidatos
Candidato.belongsTo(TituloProfesional, { foreignKey: "titulo_profesional_id" });
Candidato.belongsTo(EstadoCandidato, { foreignKey: "estado_candidato_id" });
Candidato.belongsTo(Nacionalidad, { foreignKey: "nacionalidad_id" });
Candidato.belongsTo(EstadoCivil, { foreignKey: "estado_civil_id" });
Candidato.belongsTo(Comuna, { foreignKey: "comuna_id" });
// Comentarios
Comentario.belongsTo(Candidato, { foreignKey: "candidato_id" });
Candidato.hasMany(Comentario, { foreignKey: "candidato_id" });
// Documentos
DocumentoCandidato.belongsTo(Documento, { foreignKey: "documento_id" });
DocumentoCandidato.belongsTo(Candidato, { foreignKey: "candidato_id" });
Candidato.hasMany(DocumentoCandidato, { foreignKey: "candidato_id" });
// Roles cargos
Candidato.belongsToMany(Cargo, {
  through: CandidatosCargos,
  foreignKey: "candidato_id",
  otherKey: "cargo_id",
});
Cargo.belongsToMany(Candidato, {
  through: CandidatosCargos,
  foreignKey: "cargo_id",
  otherKey: "candidato_id",
});
// Regiones y comunas
Comuna.belongsTo(Region, { foreignKey: "region_id" });
Region.hasMany(Comuna, { foreignKey: "region_id" });

Usuario.hasOne(Candidato, { foreignKey: "usuario_id" });
Candidato.belongsTo(Usuario, { foreignKey: "usuario_id" });

Convocatoria.belongsTo(Institucion, { foreignKey: "institucion_id" });
Convocatoria.belongsTo(Cargo, { foreignKey: "cargo_id" });
Convocatoria.belongsTo(Ciudad, { foreignKey: "ciudad_id" });
Convocatoria.belongsTo(EstadoConvocatoria, { foreignKey: "estado_id" });

Institucion.hasMany(Convocatoria, {
  foreignKey: "institucion_id",
});
Ciudad.hasMany(Convocatoria, { foreignKey: "ciudad_id" });
EstadoConvocatoria.hasMany(Convocatoria, {
  foreignKey: "estado_id",
});

// Joranadas
Candidato.belongsToMany(Jornada, {
  through: CandidatosJornadas,
  foreignKey: "candidato_id",
  otherKey: "jornada_id",
});
Jornada.belongsToMany(Candidato, {
  through: CandidatosJornadas,
  foreignKey: "jornada_id",
  otherKey: "candidato_id",
});

Candidato.belongsToMany(Ciudad, {
  through: CandidatosCiudades,
  foreignKey: "candidato_id",
  otherKey: "ciudades_id",
});
Ciudad.belongsToMany(Candidato, {
  through: CandidatosCiudades,
  foreignKey: "ciudades_id",
  otherKey: "candidato_id",
});

Candidato.belongsToMany(Modalidades, {
  through: CandidatosModalidades,
  foreignKey: "candidato_id",
  otherKey: "modalidad_horaria_id",
});
Ciudad.belongsToMany(Candidato, {
  through: CandidatosModalidades,
  foreignKey: "modalidad_horaria_id",
  otherKey: "candidato_id",
});

// Relación directa con tabla intermedia para incluir registros como "cargos"
Candidato.hasMany(CandidatosCargos, {
  foreignKey: "candidato_id",
});

Candidato.hasMany(CandidatosCiudades, {
  foreignKey: "candidato_id",
});

Candidato.hasMany(CandidatosJornadas, {
  foreignKey: "candidato_id",
});

Candidato.hasMany(CandidatosModalidades, {
  foreignKey: "candidato_id",
});
// =========================
// Sincronización de modelos
// =========================

export const syncModels = async () => {
  try {
    // await db.sync({ alter: true });
    await db.sync({ alter: false, force: false });
    console.log("Modelos sincronizados correctamente");
  } catch (error) {
    console.error("Error al sincronizar los modelos:", error);
  }
};
