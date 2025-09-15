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
import AuthRoutes from "../routes/authRoutes";
import uploadDocumentoCandidatoRoutes from "../routes/uploadDocumentoCandidatoRoutes";
import convocatoriaRoutes from "../routes/convocatoriasRoute";

import { syncModels } from "./index";

class Server {
  private app: Application;
  private port: number;
  private swaggerDocument = YAML.load("docs/api.yaml");
  /*   private swaggerDocument = YAML.load(
    path.resolve(__dirname, "../docs/api.yaml")
  ); */

  // Define API paths
  private apiPath = {
    auth: "/api/auth",
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
    uploadCandidatoDocumento: "/api/upload_documentoCandidato",
    convocatoria: "/api/convocatorias",
  };

  constructor() {
    this.port = process.env.PORT ? parseInt(process.env.PORT) : 8000;
    this.app = express();
    this.bdConnection();
    this.middlewares();
    this.routes();
    this.initializeErrorHandling();
  }

  private routes() {
    this.app.use(this.apiPath.auth, AuthRoutes);
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
      this.apiPath.uploadCandidatoDocumento,
      uploadDocumentoCandidatoRoutes
    );
    this.app.use(this.apiPath.convocatoria, convocatoriaRoutes);
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
    this.app.use(helmet());
    // Static folders
    this.app.use("/public", express.static(path.join(__dirname, "../public")));
    this.app.use(
      "/uploads",
      express.static(path.join(__dirname, "../uploads"))
    );
    // Swagger docs
    this.app.use(
      "/api/docs",
      swaggerUi.serve,
      swaggerUi.setup(this.swaggerDocument)
    );
  }

  private initializeErrorHandling() {
    // 404 Not Found
    this.app.use((req: Request, res: Response) => {
      res.status(404).json({ message: "Endpoint no encontrado" });
    });
    // Global Error Handler
    this.app.use(
      (err: any, _req: Request, res: Response, _next: NextFunction) => {
        console.error(err.stack);
        res
          .status(err.status || 500)
          .json({ message: err.message || "Error interno del servidor" });
      }
    );
  }

  listener() {
    this.app.listen(this.port, () => {
      console.log(`Servidor corriendo en el puerto: ${this.port}`);
    });
  }
}

export default Server;
