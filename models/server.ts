import express, { Application, Request, Response, NextFunction } from "express";
import db from "../BD/connection";
import path from "path";
import cors from "cors";
import helmet from "helmet";
import swaggerUi from "swagger-ui-express";
import YAML from "yamljs";
// Routes
import CandidatoRoutes from "../routes/candidatoRoute";
import CandidatosCargosRoutes from "../routes/candidatoCargosRoute";
import CargoRoutes from "../routes/cargoRoute";
import ComentarioRoutes from "../routes/comentarioRoute";
import ComunaRoutes from "../routes/comunaRoute";
import RegionRoutes from "../routes/regionRoute";
import DocumentoCandidatoRoutes from "../routes/documentoCandidatoRoute";
import DocumentoRoutes from "../routes/documentoRoute";
import EstadoCivilRoutes from "../routes/estadoCivilRoutes";
import EstadoCandidatoRoutes from "../routes/estadoCandidatoRoute";
import NacionaliadadRoutes from "../routes/nacionalidaRoutes";
import TituloProfesionalRoutes from "../routes/tituloProfesionalRoute";

import { syncModels } from "./index";

class Server {
  private app: Application;
  private port: number;
  private swaggerDocument = YAML.load("docs/api.yaml");
  private apiPath = {
    cargos: "/api/cargos",
    candidato: "/api/candidatos",
    candidatosCargos: "/api/candidatos_cargos",
    comentario: "/api/comentarios",
    comuna: "/api/comunas",
    doc: "/api/docs",
    documento: "/api/documentos",
    documentoCandidato: "/api/documentos_candidatos",
    estadocandidato: "/api/estado_candidatos",
    estadoCivil: "/api/estado_civiles",
    nacionalidad: "/api/nacionalidades",
    region: "/api/regiones",
    tituloProfesional: "/api/titulos_profesionales",
  };

  constructor() {
    this.port = process.env.PORT ? parseInt(process.env.PORT) : 8000;
    this.app = express();
    this.bdConnection();
    this.middlewares();
    this.routes();
  }

  private routes() {
    this.app.use(this.apiPath.candidato, CandidatoRoutes);
    this.app.use(this.apiPath.cargos, CargoRoutes);
    this.app.use(this.apiPath.candidatosCargos, CandidatosCargosRoutes);
    this.app.use(this.apiPath.comentario, ComentarioRoutes);
    this.app.use(this.apiPath.comuna, ComunaRoutes);
    this.app.use(this.apiPath.documento, DocumentoRoutes);
    this.app.use(this.apiPath.documentoCandidato, DocumentoCandidatoRoutes);
    this.app.use(this.apiPath.estadocandidato, EstadoCandidatoRoutes);
    this.app.use(this.apiPath.nacionalidad, NacionaliadadRoutes);
    this.app.use(this.apiPath.region, RegionRoutes);
    this.app.use(this.apiPath.estadoCivil, EstadoCivilRoutes);
    this.app.use(this.apiPath.tituloProfesional, TituloProfesionalRoutes);
    this.app.use(
      this.apiPath.doc,
      swaggerUi.serve,
      swaggerUi.setup(this.swaggerDocument)
    );
  }

  async bdConnection() {
    try {
      await db.authenticate();
      console.log("Database Online");
      await syncModels();
    } catch (error: any) {
      throw new Error(error);
    }
  }

  private middlewares() {
    this.app.use(cors());
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
    this.app.use("/public", express.static(path.join(__dirname, "../public")));
    this.app.use(helmet());
  }

  listener() {
    this.app.listen(this.port, () => {
      console.log(`Servidor corriendo en el puerto: ${this.port}`);
    });
  }
}

export default Server;
