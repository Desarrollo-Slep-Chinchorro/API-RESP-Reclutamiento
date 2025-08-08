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
