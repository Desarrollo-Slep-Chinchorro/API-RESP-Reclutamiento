--
-- PostgreSQL database dump
--

\restrict nfcVr2Fph3oe4bfCw6Fjfc4lO2m7QFjSMCSxZ3HMtCVmXthA07juohMkK8RGJrZ

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-10-24 16:36:39

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 6047 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 276 (class 1255 OID 18951)
-- Name: update_modified_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_modified_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 18952)
-- Name: candidatos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidatos (
    id integer NOT NULL,
    rut character varying(12) NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    titulo_profesional_id integer,
    telefono character varying(15),
    correo character varying(100),
    estado_candidato_id integer DEFAULT 1,
    nacionalidad_id integer,
    estado_civil_id integer,
    direccion character varying(255),
    comuna_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    usuario_id integer NOT NULL,
    presentacion character varying(1000),
    fecha_nacimiento date,
    categoria_funcionaria_id integer,
    nivel_educacion_id integer,
    tipo_vacante_nuevo boolean,
    tipo_vacante_reemplazo boolean,
    especialidad text,
    CONSTRAINT candidatos_correo_check CHECK (((correo)::text ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text)),
    CONSTRAINT candidatos_rut_check CHECK (((rut)::text ~ '^\d{7,8}-[\dkK]$'::text)),
    CONSTRAINT candidatos_telefono_check CHECK (((telefono)::text ~ '^\+?\d{8,12}$'::text))
);


ALTER TABLE public.candidatos OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 18961)
-- Name: candidatos_cargos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidatos_cargos (
    candidato_id integer NOT NULL,
    cargo_id integer NOT NULL
);


ALTER TABLE public.candidatos_cargos OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18964)
-- Name: candidatos_ciudades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidatos_ciudades (
    id integer NOT NULL,
    candidato_id integer NOT NULL,
    ciudades_id integer NOT NULL
);


ALTER TABLE public.candidatos_ciudades OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 18967)
-- Name: candidatos_ciudades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.candidatos_ciudades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.candidatos_ciudades_id_seq OWNER TO postgres;

--
-- TOC entry 6049 (class 0 OID 0)
-- Dependencies: 220
-- Name: candidatos_ciudades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.candidatos_ciudades_id_seq OWNED BY public.candidatos_ciudades.id;


--
-- TOC entry 221 (class 1259 OID 18968)
-- Name: candidatos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.candidatos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.candidatos_id_seq OWNER TO postgres;

--
-- TOC entry 6050 (class 0 OID 0)
-- Dependencies: 221
-- Name: candidatos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.candidatos_id_seq OWNED BY public.candidatos.id;


--
-- TOC entry 222 (class 1259 OID 18969)
-- Name: candidatos_jornadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidatos_jornadas (
    id integer NOT NULL,
    candidato_id integer NOT NULL,
    jornada_id integer
);


ALTER TABLE public.candidatos_jornadas OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 18972)
-- Name: candidatos_jornadas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.candidatos_jornadas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.candidatos_jornadas_id_seq OWNER TO postgres;

--
-- TOC entry 6051 (class 0 OID 0)
-- Dependencies: 223
-- Name: candidatos_jornadas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.candidatos_jornadas_id_seq OWNED BY public.candidatos_jornadas.id;


--
-- TOC entry 224 (class 1259 OID 18973)
-- Name: candidatos_modalidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidatos_modalidades (
    id integer NOT NULL,
    candidato_id integer NOT NULL,
    modalidad_horaria_id integer NOT NULL
);


ALTER TABLE public.candidatos_modalidades OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18976)
-- Name: candidatos_modalidades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.candidatos_modalidades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.candidatos_modalidades_id_seq OWNER TO postgres;

--
-- TOC entry 6052 (class 0 OID 0)
-- Dependencies: 225
-- Name: candidatos_modalidades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.candidatos_modalidades_id_seq OWNED BY public.candidatos_modalidades.id;


--
-- TOC entry 226 (class 1259 OID 18977)
-- Name: cargos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo_cargo_id integer
);


ALTER TABLE public.cargos OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 18980)
-- Name: cargos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cargos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cargos_id_seq OWNER TO postgres;

--
-- TOC entry 6053 (class 0 OID 0)
-- Dependencies: 227
-- Name: cargos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cargos_id_seq OWNED BY public.cargos.id;


--
-- TOC entry 273 (class 1259 OID 20402)
-- Name: cartas_ofertas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cartas_ofertas (
    id integer NOT NULL,
    convocatoria_id integer,
    candidato_id integer,
    institucion_id integer,
    cargo_id integer,
    jornada_id integer,
    fecha_ingreso date,
    estado integer,
    fecha_apr_director timestamp with time zone,
    fecha_envio_dir timestamp with time zone,
    glosa_remuneracion text
);


ALTER TABLE public.cartas_ofertas OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 20401)
-- Name: cartas_ofertas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cartas_ofertas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cartas_ofertas_id_seq OWNER TO postgres;

--
-- TOC entry 6054 (class 0 OID 0)
-- Dependencies: 272
-- Name: cartas_ofertas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartas_ofertas_id_seq OWNED BY public.cartas_ofertas.id;


--
-- TOC entry 228 (class 1259 OID 18981)
-- Name: categoria_cargos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria_cargos (
    id integer NOT NULL,
    nombre text
);


ALTER TABLE public.categoria_cargos OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 18986)
-- Name: categoria_cargos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_cargos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_cargos_id_seq OWNER TO postgres;

--
-- TOC entry 6055 (class 0 OID 0)
-- Dependencies: 229
-- Name: categoria_cargos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_cargos_id_seq OWNED BY public.categoria_cargos.id;


--
-- TOC entry 230 (class 1259 OID 18987)
-- Name: ciudades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciudades (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.ciudades OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 18992)
-- Name: ciudades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ciudades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ciudades_id_seq OWNER TO postgres;

--
-- TOC entry 6056 (class 0 OID 0)
-- Dependencies: 231
-- Name: ciudades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ciudades_id_seq OWNED BY public.ciudades.id;


--
-- TOC entry 232 (class 1259 OID 18993)
-- Name: comentarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentarios (
    id integer NOT NULL,
    candidato_id integer NOT NULL,
    descripcion text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    creador_id integer
);


ALTER TABLE public.comentarios OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 18998)
-- Name: comentarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comentarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comentarios_id_seq OWNER TO postgres;

--
-- TOC entry 6057 (class 0 OID 0)
-- Dependencies: 233
-- Name: comentarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentarios_id_seq OWNED BY public.comentarios.id;


--
-- TOC entry 234 (class 1259 OID 18999)
-- Name: comunas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comunas (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    region_id integer NOT NULL
);


ALTER TABLE public.comunas OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 19002)
-- Name: comunas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comunas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comunas_id_seq OWNER TO postgres;

--
-- TOC entry 6058 (class 0 OID 0)
-- Dependencies: 235
-- Name: comunas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comunas_id_seq OWNED BY public.comunas.id;


--
-- TOC entry 236 (class 1259 OID 19003)
-- Name: convocatorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.convocatorias (
    id integer NOT NULL,
    codigo text,
    cargo_id integer,
    ciudad_id integer,
    institucion_id integer,
    fecha_cierre date,
    descripcion text,
    requisitos text,
    created_at timestamp with time zone DEFAULT now(),
    estado_id integer DEFAULT 1,
    modalidad_id integer,
    tipo_vacante_id integer,
    jornada_id integer,
    categoria_cargo_id integer
);


ALTER TABLE public.convocatorias OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 19010)
-- Name: convocatorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.convocatorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.convocatorias_id_seq OWNER TO postgres;

--
-- TOC entry 6059 (class 0 OID 0)
-- Dependencies: 237
-- Name: convocatorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.convocatorias_id_seq OWNED BY public.convocatorias.id;


--
-- TOC entry 271 (class 1259 OID 20122)
-- Name: directores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directores (
    id integer NOT NULL,
    rut text NOT NULL,
    nombre text,
    correo text,
    estado boolean DEFAULT true
);


ALTER TABLE public.directores OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 20121)
-- Name: directores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directores_id_seq OWNER TO postgres;

--
-- TOC entry 6060 (class 0 OID 0)
-- Dependencies: 270
-- Name: directores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directores_id_seq OWNED BY public.directores.id;


--
-- TOC entry 238 (class 1259 OID 19011)
-- Name: documentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documentos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    fase_candidato integer
);


ALTER TABLE public.documentos OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 19014)
-- Name: documentos_candidatos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documentos_candidatos (
    id integer NOT NULL,
    documento_id integer NOT NULL,
    candidato_id integer NOT NULL,
    ruta character varying(255) NOT NULL,
    nombre text,
    created_at timestamp with time zone NOT NULL,
    nombre_para_mostrar text
);


ALTER TABLE public.documentos_candidatos OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 19019)
-- Name: documentos_candidatos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documentos_candidatos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.documentos_candidatos_id_seq OWNER TO postgres;

--
-- TOC entry 6061 (class 0 OID 0)
-- Dependencies: 240
-- Name: documentos_candidatos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documentos_candidatos_id_seq OWNED BY public.documentos_candidatos.id;


--
-- TOC entry 241 (class 1259 OID 19020)
-- Name: documentos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documentos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.documentos_id_seq OWNER TO postgres;

--
-- TOC entry 6062 (class 0 OID 0)
-- Dependencies: 241
-- Name: documentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documentos_id_seq OWNED BY public.documentos.id;


--
-- TOC entry 242 (class 1259 OID 19021)
-- Name: estado_candidatos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado_candidatos (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.estado_candidatos OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 19024)
-- Name: estado_candidatos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_candidatos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estado_candidatos_id_seq OWNER TO postgres;

--
-- TOC entry 6063 (class 0 OID 0)
-- Dependencies: 243
-- Name: estado_candidatos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_candidatos_id_seq OWNED BY public.estado_candidatos.id;


--
-- TOC entry 275 (class 1259 OID 20442)
-- Name: estado_carta_oferta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado_carta_oferta (
    id integer NOT NULL,
    nombre text
);


ALTER TABLE public.estado_carta_oferta OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 20441)
-- Name: estado_carta_oferta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_carta_oferta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estado_carta_oferta_id_seq OWNER TO postgres;

--
-- TOC entry 6064 (class 0 OID 0)
-- Dependencies: 274
-- Name: estado_carta_oferta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_carta_oferta_id_seq OWNED BY public.estado_carta_oferta.id;


--
-- TOC entry 244 (class 1259 OID 19025)
-- Name: estado_convocatoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado_convocatoria (
    id integer NOT NULL,
    nombre text
);


ALTER TABLE public.estado_convocatoria OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 19030)
-- Name: estado_convocatoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_convocatoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estado_convocatoria_id_seq OWNER TO postgres;

--
-- TOC entry 6065 (class 0 OID 0)
-- Dependencies: 245
-- Name: estado_convocatoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_convocatoria_id_seq OWNED BY public.estado_convocatoria.id;


--
-- TOC entry 246 (class 1259 OID 19031)
-- Name: estados_civiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados_civiles (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.estados_civiles OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 19034)
-- Name: estados_civiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_civiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estados_civiles_id_seq OWNER TO postgres;

--
-- TOC entry 6066 (class 0 OID 0)
-- Dependencies: 247
-- Name: estados_civiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_civiles_id_seq OWNED BY public.estados_civiles.id;


--
-- TOC entry 248 (class 1259 OID 19035)
-- Name: instituciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instituciones (
    id integer NOT NULL,
    nombre text,
    correo text,
    ciudad_id integer,
    director_id integer,
    activo boolean
);


ALTER TABLE public.instituciones OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 19040)
-- Name: instituciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instituciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instituciones_id_seq OWNER TO postgres;

--
-- TOC entry 6067 (class 0 OID 0)
-- Dependencies: 249
-- Name: instituciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instituciones_id_seq OWNED BY public.instituciones.id;


--
-- TOC entry 250 (class 1259 OID 19041)
-- Name: jornadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jornadas (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.jornadas OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 19046)
-- Name: jornadas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jornadas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jornadas_id_seq OWNER TO postgres;

--
-- TOC entry 6068 (class 0 OID 0)
-- Dependencies: 251
-- Name: jornadas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jornadas_id_seq OWNED BY public.jornadas.id;


--
-- TOC entry 252 (class 1259 OID 19047)
-- Name: mensajes_web; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mensajes_web (
    id integer NOT NULL,
    nombre text NOT NULL,
    correo text NOT NULL,
    mensaje text NOT NULL,
    rut character varying(10) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    estado boolean DEFAULT true NOT NULL
);


ALTER TABLE public.mensajes_web OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 19054)
-- Name: mensajes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mensajes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mensajes_id_seq OWNER TO postgres;

--
-- TOC entry 6069 (class 0 OID 0)
-- Dependencies: 253
-- Name: mensajes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mensajes_id_seq OWNED BY public.mensajes_web.id;


--
-- TOC entry 254 (class 1259 OID 19055)
-- Name: modalidades_horarias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modalidades_horarias (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.modalidades_horarias OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 19060)
-- Name: modalidades_horarias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modalidades_horarias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.modalidades_horarias_id_seq OWNER TO postgres;

--
-- TOC entry 6070 (class 0 OID 0)
-- Dependencies: 255
-- Name: modalidades_horarias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modalidades_horarias_id_seq OWNED BY public.modalidades_horarias.id;


--
-- TOC entry 256 (class 1259 OID 19061)
-- Name: nacionalidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nacionalidades (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.nacionalidades OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 19064)
-- Name: nacionalidades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nacionalidades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nacionalidades_id_seq OWNER TO postgres;

--
-- TOC entry 6071 (class 0 OID 0)
-- Dependencies: 257
-- Name: nacionalidades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nacionalidades_id_seq OWNED BY public.nacionalidades.id;


--
-- TOC entry 258 (class 1259 OID 19065)
-- Name: nivel_educacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nivel_educacion (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.nivel_educacion OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 19068)
-- Name: nivel_educacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nivel_educacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nivel_educacion_id_seq OWNER TO postgres;

--
-- TOC entry 6072 (class 0 OID 0)
-- Dependencies: 259
-- Name: nivel_educacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nivel_educacion_id_seq OWNED BY public.nivel_educacion.id;


--
-- TOC entry 260 (class 1259 OID 19069)
-- Name: postulaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postulaciones (
    id integer NOT NULL,
    candidato_id integer,
    convocatoria_id integer,
    created_at timestamp with time zone DEFAULT now(),
    estado boolean DEFAULT false
);


ALTER TABLE public.postulaciones OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 19074)
-- Name: postulaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.postulaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.postulaciones_id_seq OWNER TO postgres;

--
-- TOC entry 6073 (class 0 OID 0)
-- Dependencies: 261
-- Name: postulaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.postulaciones_id_seq OWNED BY public.postulaciones.id;


--
-- TOC entry 262 (class 1259 OID 19075)
-- Name: regiones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regiones (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.regiones OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 19078)
-- Name: regiones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regiones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regiones_id_seq OWNER TO postgres;

--
-- TOC entry 6074 (class 0 OID 0)
-- Dependencies: 263
-- Name: regiones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regiones_id_seq OWNED BY public.regiones.id;


--
-- TOC entry 264 (class 1259 OID 19079)
-- Name: tipo_vacantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_vacantes (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.tipo_vacantes OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 19084)
-- Name: tipo_vacante_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_vacante_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipo_vacante_id_seq OWNER TO postgres;

--
-- TOC entry 6075 (class 0 OID 0)
-- Dependencies: 265
-- Name: tipo_vacante_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_vacante_id_seq OWNED BY public.tipo_vacantes.id;


--
-- TOC entry 266 (class 1259 OID 19085)
-- Name: titulos_profesionales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.titulos_profesionales (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.titulos_profesionales OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 19088)
-- Name: titulos_profesionales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.titulos_profesionales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.titulos_profesionales_id_seq OWNER TO postgres;

--
-- TOC entry 6076 (class 0 OID 0)
-- Dependencies: 267
-- Name: titulos_profesionales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.titulos_profesionales_id_seq OWNED BY public.titulos_profesionales.id;


--
-- TOC entry 268 (class 1259 OID 19089)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    usuario text NOT NULL,
    password text NOT NULL,
    estado boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    rol character varying(50) DEFAULT USER NOT NULL,
    uid text
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 19095)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 6077 (class 0 OID 0)
-- Dependencies: 269
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 4887 (class 2604 OID 19096)
-- Name: candidatos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos ALTER COLUMN id SET DEFAULT nextval('public.candidatos_id_seq'::regclass);


--
-- TOC entry 4889 (class 2604 OID 19097)
-- Name: candidatos_ciudades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_ciudades ALTER COLUMN id SET DEFAULT nextval('public.candidatos_ciudades_id_seq'::regclass);


--
-- TOC entry 4890 (class 2604 OID 19098)
-- Name: candidatos_jornadas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_jornadas ALTER COLUMN id SET DEFAULT nextval('public.candidatos_jornadas_id_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 19099)
-- Name: candidatos_modalidades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_modalidades ALTER COLUMN id SET DEFAULT nextval('public.candidatos_modalidades_id_seq'::regclass);


--
-- TOC entry 4892 (class 2604 OID 19100)
-- Name: cargos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos ALTER COLUMN id SET DEFAULT nextval('public.cargos_id_seq'::regclass);


--
-- TOC entry 4923 (class 2604 OID 20405)
-- Name: cartas_ofertas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartas_ofertas ALTER COLUMN id SET DEFAULT nextval('public.cartas_ofertas_id_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 19101)
-- Name: categoria_cargos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria_cargos ALTER COLUMN id SET DEFAULT nextval('public.categoria_cargos_id_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 19102)
-- Name: ciudades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudades ALTER COLUMN id SET DEFAULT nextval('public.ciudades_id_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 19103)
-- Name: comentarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios ALTER COLUMN id SET DEFAULT nextval('public.comentarios_id_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 19104)
-- Name: comunas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comunas ALTER COLUMN id SET DEFAULT nextval('public.comunas_id_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 19105)
-- Name: convocatorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias ALTER COLUMN id SET DEFAULT nextval('public.convocatorias_id_seq'::regclass);


--
-- TOC entry 4921 (class 2604 OID 20125)
-- Name: directores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directores ALTER COLUMN id SET DEFAULT nextval('public.directores_id_seq'::regclass);


--
-- TOC entry 4900 (class 2604 OID 19106)
-- Name: documentos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos ALTER COLUMN id SET DEFAULT nextval('public.documentos_id_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 19107)
-- Name: documentos_candidatos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_candidatos ALTER COLUMN id SET DEFAULT nextval('public.documentos_candidatos_id_seq'::regclass);


--
-- TOC entry 4902 (class 2604 OID 19108)
-- Name: estado_candidatos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos ALTER COLUMN id SET DEFAULT nextval('public.estado_candidatos_id_seq'::regclass);


--
-- TOC entry 4924 (class 2604 OID 20445)
-- Name: estado_carta_oferta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_carta_oferta ALTER COLUMN id SET DEFAULT nextval('public.estado_carta_oferta_id_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 19109)
-- Name: estado_convocatoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_convocatoria ALTER COLUMN id SET DEFAULT nextval('public.estado_convocatoria_id_seq'::regclass);


--
-- TOC entry 4904 (class 2604 OID 19110)
-- Name: estados_civiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles ALTER COLUMN id SET DEFAULT nextval('public.estados_civiles_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 19111)
-- Name: instituciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instituciones ALTER COLUMN id SET DEFAULT nextval('public.instituciones_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 19112)
-- Name: jornadas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jornadas ALTER COLUMN id SET DEFAULT nextval('public.jornadas_id_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 19113)
-- Name: mensajes_web id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes_web ALTER COLUMN id SET DEFAULT nextval('public.mensajes_id_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 19114)
-- Name: modalidades_horarias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modalidades_horarias ALTER COLUMN id SET DEFAULT nextval('public.modalidades_horarias_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 19115)
-- Name: nacionalidades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades ALTER COLUMN id SET DEFAULT nextval('public.nacionalidades_id_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 19116)
-- Name: nivel_educacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_educacion ALTER COLUMN id SET DEFAULT nextval('public.nivel_educacion_id_seq'::regclass);


--
-- TOC entry 4913 (class 2604 OID 19117)
-- Name: postulaciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postulaciones ALTER COLUMN id SET DEFAULT nextval('public.postulaciones_id_seq'::regclass);


--
-- TOC entry 4916 (class 2604 OID 19118)
-- Name: regiones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones ALTER COLUMN id SET DEFAULT nextval('public.regiones_id_seq'::regclass);


--
-- TOC entry 4917 (class 2604 OID 19119)
-- Name: tipo_vacantes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_vacantes ALTER COLUMN id SET DEFAULT nextval('public.tipo_vacante_id_seq'::regclass);


--
-- TOC entry 4918 (class 2604 OID 19120)
-- Name: titulos_profesionales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales ALTER COLUMN id SET DEFAULT nextval('public.titulos_profesionales_id_seq'::regclass);


--
-- TOC entry 4919 (class 2604 OID 19121)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 5983 (class 0 OID 18952)
-- Dependencies: 217
-- Data for Name: candidatos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.candidatos (id, rut, nombre_completo, titulo_profesional_id, telefono, correo, estado_candidato_id, nacionalidad_id, estado_civil_id, direccion, comuna_id, created_at, updated_at, usuario_id, presentacion, fecha_nacimiento, categoria_funcionaria_id, nivel_educacion_id, tipo_vacante_nuevo, tipo_vacante_reemplazo, especialidad) FROM stdin;
2	20217385-3	Isabel Yesenia Zapata Maldonado	\N	\N	isabel.zapatama@epchinchorro.cl	1	\N	\N	\N	\N	2025-10-22 11:12:57.161-03	2025-10-22 11:12:57.161-03	2	\N	\N	\N	\N	\N	\N	\N
4	12607595-2	Roberto Fuentes	\N	\N	roberto.fuentes@epchinchorro.cl	1	\N	\N	\N	\N	2025-10-22 11:25:49.465-03	2025-10-22 11:25:49.465-03	4	\N	\N	\N	\N	\N	\N	\N
3	16469777-0	Yasna Vildoso Barbieri	\N	\N	yas.vildoso.b@gmail.com	2	\N	\N	\N	\N	2025-10-22 11:24:38.9-03	2025-10-23 12:20:58.312175-03	3	\N	\N	\N	\N	\N	\N	\N
1	16467901-2	Jhon Smith	15	\N	ma@ep.com	3	\N	\N	\N	\N	2025-10-22 11:09:50.85-03	2025-10-24 16:06:04.080675-03	1	\N	\N	3	9	t	f	Tecnologías e Innovación
\.


--
-- TOC entry 5984 (class 0 OID 18961)
-- Dependencies: 218
-- Data for Name: candidatos_cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.candidatos_cargos (candidato_id, cargo_id) FROM stdin;
1	10
\.


--
-- TOC entry 5985 (class 0 OID 18964)
-- Dependencies: 219
-- Data for Name: candidatos_ciudades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.candidatos_ciudades (id, candidato_id, ciudades_id) FROM stdin;
1	1	1
2	1	3
\.


--
-- TOC entry 5988 (class 0 OID 18969)
-- Dependencies: 222
-- Data for Name: candidatos_jornadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.candidatos_jornadas (id, candidato_id, jornada_id) FROM stdin;
1	1	1
2	1	3
\.


--
-- TOC entry 5990 (class 0 OID 18973)
-- Dependencies: 224
-- Data for Name: candidatos_modalidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.candidatos_modalidades (id, candidato_id, modalidad_horaria_id) FROM stdin;
1	1	1
\.


--
-- TOC entry 5992 (class 0 OID 18977)
-- Dependencies: 226
-- Data for Name: cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cargos (id, nombre, tipo_cargo_id) FROM stdin;
1	Inspector(a) de patio	1
2	Portero(a)	1
3	Secretario(a)	1
4	Auxiliar de Aseo	2
5	Chofer / Conductor Escolar	2
6	Vigilante nocturno	2
7	Fonoaudiólogo(a)	3
8	Psicólogo(a)	3
9	Terapeuta Ocupacional	3
10	Trabajador(a) Social	3
11	Técnico en Atención de Párvulos	4
12	Técnico en Educación Especial	4
13	Asistente Informático / Soporte TIC	4
14	Educador(a) de Párvulos	5
15	Docente Diferencial	5
16	Docente de Artes Visuales	5
17	Docente de Biología	5
18	Docente de Ciencias Naturales	5
19	Docente de Educación Física	5
20	Docente de Física	5
21	Docente de Filosofía	5
22	Docente de Historia	5
23	Docente de Inglés	5
24	Educador(a) Tradicional	5
25	Docente de Lenguaje	5
26	Docente CRA	5
27	Docente de Enlace	5
28	Docente de Matemática	5
29	Docente de Música	5
30	Docente de Química	5
31	Docente de Religión	5
32	Docente Explotación Minera (Técnico Profesional)	5
33	Docente Enfermería (Técnico Profesional)	5
34	Docente Administración (Técnico Profesional)	5
35	Docente Electricidad (Técnico Profesional)	5
36	Docente Gastronomía (Técnico Profesional)	5
37	Docente Atención de Párvulos (Técnico Profesional)	5
38	Docente Construcciones Metálicas (Técnico Profesional)	5
39	Docente Mecánica Automotriz (Técnico Profesional)	5
40	Docente Electrónica (Técnico Profesional)	5
41	Docente Contabilidad (Técnico Profesional)	5
42	Docente Conectividad y Redes (Técnico Profesional)	5
43	Docente Mecánica Industrial (Técnico Profesional)	5
44	Docente Agronomía (Técnico Profesional)	5
\.


--
-- TOC entry 6039 (class 0 OID 20402)
-- Dependencies: 273
-- Data for Name: cartas_ofertas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cartas_ofertas (id, convocatoria_id, candidato_id, institucion_id, cargo_id, jornada_id, fecha_ingreso, estado, fecha_apr_director, fecha_envio_dir, glosa_remuneracion) FROM stdin;
4	1	1	1	1	1	\N	1	\N	\N	\N
\.


--
-- TOC entry 5994 (class 0 OID 18981)
-- Dependencies: 228
-- Data for Name: categoria_cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria_cargos (id, nombre) FROM stdin;
1	Asistente de la Educación / Administrativo
2	Asistente de la Educación / Auxiliar
3	Asistente de la Educación / Profesional
4	Asistente de la Educación / Técnico
5	Docente
\.


--
-- TOC entry 5996 (class 0 OID 18987)
-- Dependencies: 230
-- Data for Name: ciudades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ciudades (id, nombre) FROM stdin;
1	Arica
2	Putre
3	Valle de Azapa
4	Valle de Lluta
5	General Lagos
6	Camarones
7	Valle de Chaca
\.


--
-- TOC entry 5998 (class 0 OID 18993)
-- Dependencies: 232
-- Data for Name: comentarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comentarios (id, candidato_id, descripcion, created_at, creador_id) FROM stdin;
\.


--
-- TOC entry 6000 (class 0 OID 18999)
-- Dependencies: 234
-- Data for Name: comunas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comunas (id, nombre, region_id) FROM stdin;
1	Arica	1
2	Camarones	1
3	Putre	1
4	General Lagos	1
5	Iquique	2
6	Alto Hospicio	2
7	Pozo Almonte	2
8	Camiña	2
9	Colchane	2
10	Huara	2
11	Pica	2
12	Antofagasta	3
13	Mejillones	3
14	Sierra Gorda	3
15	Taltal	3
16	Calama	3
17	Ollagüe	3
18	San Pedro de Atacama	3
19	Tocopilla	3
20	María Elena	3
21	Copiapó	4
22	Caldera	4
23	Tierra Amarilla	4
24	Chañaral	4
25	Diego de Almagro	4
26	Vallenar	4
27	Alto del Carmen	4
28	Freirina	4
29	Huasco	4
30	La Serena	5
31	Coquimbo	5
32	Andacollo	5
33	La Higuera	5
34	Paiguano	5
35	Vicuña	5
36	Illapel	5
37	Canela	5
38	Los Vilos	5
39	Salamanca	5
40	Ovalle	5
41	Combarbalá	5
42	Monte Patria	5
43	Punitaqui	5
44	Río Hurtado	5
45	Valparaíso	6
46	Casablanca	6
47	Concón	6
48	Juan Fernández	6
49	Puchuncaví	6
50	Quintero	6
51	Viña del Mar	6
52	Isla de Pascua	6
53	Los Andes	6
54	Calle Larga	6
55	Rinconada	6
56	San Esteban	6
57	La Ligua	6
58	Cabildo	6
59	Papudo	6
60	Petorca	6
61	Zapallar	6
62	Quillota	6
63	Calera	6
64	Hijuelas	6
65	La Cruz	6
66	Nogales	6
67	San Antonio	6
68	Algarrobo	6
69	Cartagena	6
70	El Quisco	6
71	El Tabo	6
72	Santo Domingo	6
73	San Felipe	6
74	Catemu	6
75	Llaillay	6
76	Panquehue	6
77	Putaendo	6
78	Santa María	6
79	Quilpué	6
80	Limache	6
81	Olmué	6
82	Villa Alemana	6
83	Santiago	7
84	Cerrillos	7
85	Cerro Navia	7
86	Conchalí	7
87	El Bosque	7
88	Estación Central	7
89	Huechuraba	7
90	Independencia	7
91	La Cisterna	7
92	La Florida	7
93	La Granja	7
94	La Pintana	7
95	La Reina	7
96	Las Condes	7
97	Lo Barnechea	7
98	Lo Espejo	7
99	Lo Prado	7
100	Macul	7
101	Maipú	7
102	Ñuñoa	7
103	Pedro Aguirre Cerda	7
104	Peñalolén	7
105	Providencia	7
106	Pudahuel	7
107	Quilicura	7
108	Quinta Normal	7
109	Recoleta	7
110	Renca	7
111	San Joaquín	7
112	San Miguel	7
113	San Ramón	7
114	Vitacura	7
115	Puente Alto	7
116	Pirque	7
117	San José de Maipo	7
118	Colina	7
119	Lampa	7
120	Tiltil	7
121	San Bernardo	7
122	Buin	7
123	Calera de Tango	7
124	Paine	7
125	Melipilla	7
126	Alhué	7
127	Curacaví	7
128	María Pinto	7
129	San Pedro	7
130	Talagante	7
131	El Monte	7
132	Isla de Maipo	7
133	Padre Hurtado	7
134	Peñaflor	7
135	Rancagua	8
136	Codegua	8
137	Coinco	8
138	Coltauco	8
139	Doñihue	8
140	Graneros	8
141	Las Cabras	8
142	Machalí	8
143	Malloa	8
144	Mostazal	8
145	Olivar	8
146	Peumo	8
147	Pichidegua	8
148	Quinta de Tilcoco	8
149	Rengo	8
150	Requínoa	8
151	San Vicente	8
152	Pichilemu	8
153	La Estrella	8
154	Litueche	8
155	Marchihue	8
156	Navidad	8
157	Paredones	8
158	San Fernando	8
159	Chépica	8
160	Chimbarongo	8
161	Lolol	8
162	Nancagua	8
163	Palmilla	8
164	Peralillo	8
165	Placilla	8
166	Pumanque	8
167	Santa Cruz	8
168	Talca	9
169	Constitución	9
170	Curepto	9
171	Empedrado	9
172	Maule	9
173	Pelarco	9
174	Pencahue	9
175	Río Claro	9
176	San Clemente	9
177	San Rafael	9
178	Cauquenes	9
179	Chanco	9
180	Pelluhue	9
181	Curicó	9
182	Hualañé	9
183	Licantén	9
184	Molina	9
185	Rauco	9
186	Romeral	9
187	Sagrada Familia	9
188	Teno	9
189	Vichuquén	9
190	Linares	9
191	Colbún	9
192	Longaví	9
193	Parral	9
194	Retiro	9
195	San Javier	9
196	Villa Alegre	9
197	Yerbas Buenas	9
198	Chillán	10
199	Bulnes	10
200	Chillán Viejo	10
201	El Carmen	10
202	Pemuco	10
203	Pinto	10
204	Quillón	10
205	San Ignacio	10
206	Yungay	10
207	Cobquecura	10
208	Coelemu	10
209	Ninhue	10
210	Portezuelo	10
211	Quirihue	10
212	Ránquil	10
213	Treguaco	10
214	Coihueco	10
215	Ñiquén	10
216	San Carlos	10
217	San Fabián	10
218	San Nicolás	10
219	Concepción	11
220	Coronel	11
221	Chiguayante	11
222	Florida	11
223	Hualpén	11
224	Hualqui	11
225	Lota	11
226	Penco	11
227	San Pedro de la Paz	11
228	Santa Juana	11
229	Talcahuano	11
230	Tomé	11
231	Lebu	11
232	Arauco	11
233	Cañete	11
234	Contulmo	11
235	Curanilahue	11
236	Los Álamos	11
237	Tirúa	11
238	Los Ángeles	11
239	Antuco	11
240	Cabrero	11
241	Laja	11
242	Mulchén	11
243	Nacimiento	11
244	Negrete	11
245	Quilaco	11
246	Quilleco	11
247	San Rosendo	11
248	Santa Bárbara	11
249	Tucapel	11
250	Yumbel	11
251	Alto Biobío	11
252	Temuco	12
253	Carahue	12
254	Cunco	12
255	Curarrehue	12
256	Freire	12
257	Galvarino	12
258	Gorbea	12
259	Lautaro	12
260	Loncoche	12
261	Melipeuco	12
262	Nueva Imperial	12
263	Padre las Casas	12
264	Perquenco	12
265	Pitrufquén	12
266	Pucón	12
267	Saavedra	12
268	Teodoro Schmidt	12
269	Toltén	12
270	Vilcún	12
271	Villarrica	12
272	Angol	12
273	Collipulli	12
274	Curacautín	12
275	Ercilla	12
276	Lonquimay	12
277	Los Sauces	12
278	Lumaco	12
279	Purén	12
280	Renaico	12
281	Traiguén	12
282	Victoria	12
283	Valdivia	13
284	Corral	13
285	Lanco	13
286	Los Lagos	13
287	Máfil	13
288	Mariquina	13
289	Paillaco	13
290	Panguipulli	13
291	La Unión	13
292	Futrono	13
293	Lago Ranco	13
294	Río Bueno	13
295	Puerto Montt	14
296	Calbuco	14
297	Cochamó	14
298	Fresia	14
299	Frutillar	14
300	Los Muermos	14
301	Llanquihue	14
302	Maullín	14
303	Puerto Varas	14
304	Castro	14
305	Ancud	14
306	Chonchi	14
307	Curaco de Vélez	14
308	Dalcahue	14
309	Puqueldón	14
310	Queilén	14
311	Quellón	14
312	Quemchi	14
313	Quinchao	14
314	Osorno	14
315	Puerto Octay	14
316	Purranque	14
317	Puyehue	14
318	Río Negro	14
319	San Juan de la Costa	14
320	San Pablo	14
321	Chaitén	14
322	Futaleufú	14
323	Hualaihué	14
324	Palena	14
325	Coihaique	15
326	Lago Verde	15
327	Aysén	15
328	Cisnes	15
329	Guaitecas	15
330	Cochrane	15
331	O'Higgins	15
332	Tortel	15
333	Chile Chico	15
334	Río Ibáñez	15
335	Punta Arenas	16
336	Laguna Blanca	16
337	Río Verde	16
338	San Gregorio	16
339	Cabo de Hornos	16
340	Antártica	16
341	Porvenir	16
342	Primavera	16
343	Timaukel	16
344	Natales	16
345	Torres del Paine	16
\.


--
-- TOC entry 6002 (class 0 OID 19003)
-- Dependencies: 236
-- Data for Name: convocatorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.convocatorias (id, codigo, cargo_id, ciudad_id, institucion_id, fecha_cierre, descripcion, requisitos, created_at, estado_id, modalidad_id, tipo_vacante_id, jornada_id, categoria_cargo_id) FROM stdin;
1	SLEP-ASI-5462-2025	1	1	1	2025-10-24	Se requiere auxiliar de mantención para apoyar las labores generales del establecimiento, incluyendo el aseo y conservación de espacios interiores y exteriores, apoyo en traslados de materiales y tareas menores de reparación y mantenimiento.	- Enseñanza media completa.\n- Deseable experiencia en labores de mantención o servicios generales.	2025-10-22 11:36:13.062258-03	4	1	1	1	1
\.


--
-- TOC entry 6037 (class 0 OID 20122)
-- Dependencies: 271
-- Data for Name: directores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directores (id, rut, nombre, correo, estado) FROM stdin;
1	10226593-9	PABLO ORNALDO VALENZUELA HUANCA	pablo.valenzuela@epchinchorro.cl	t
2	15008899-2	VERÓNICA ISABEL MONTENEGRO PINTO	veronica.montenegro@epchinchorro.cl	t
3	15420433-4	PABLO EMILIO CÁDIZ CHACÓN	pablo.cadizch@slepchinchorro.cl	t
4	9633161-4	NELSON EDUARDO CABEZAS MELLER	nelson.cabezas@epchinchorro.cl	t
5	10684126-8	MAYCOLE FRANCOISE SALAMANCA WELSCH	maycole.salamanca@epchinchorro.cl	t
6	6800995-2	NICOLAS MONTECINOS GONZALEZ	nicolas.montecinos@epchinchorro.cl	t
7	10213659-4	XIMENA ELOÍSA SÁNCHEZ CARVAJAL	ximena.sanchez@epchinchorro.cl	t
8	9532014-7	MOIRA ALEJANDRA DONOSO MALUF	moira.donoso@epchinchorro.cl	t
9	12436803-0	PAMELA DEL CARMEN VILLEGAS MELGAREJO	pamela.villegasme@slepchinchorro.cl	t
10	9374262-1	ROSS MARIE ARLETTE DÍAZ TABILO	ross.diaz@epchinchorro.cl	t
11	13212667-4	ALEJANDRA CARMEN ESPINOZA DIAZ	alejandra.espinoza@epchinchorro.cl	t
12	9068699-2	ISABEL DEL PILAR GARCÍA NÚÑEZ	isabel.garcia@epchinchorro.cl	t
13	9730512-9	MONICA HERNANDEZ VARAS	monica.hernandez@epchinchorro.cl	t
14	15008136-K	ALONSO JAVIER CARREÑO SÁEZ	alonso.carreno@epchinchorro.cl	t
15	10393102-9	ALICIA MAURA ARANCIBIA RIVEROS	alicia.arancibiari@slepchinchorro.cl	t
16	17011741-7	RICARDO FAVIO RAMIREZ CHOQUE	ricardo.ramirez@epchinchorro.cl	t
17	10769856-6	ANÍBAL ALEJANDRO COFRÉ MORALES	anibal.cofre@epchinchorro.cl	t
18	9020152-2	LEONTINA DEL CARMEN LOPEZ NAVARRO	leontina.lopez@epchinchorro.cl	t
19	15511158-5	FELIPE FABIAN JERIA ACOSTA	felipe.jeria@epchinchorro.cl	t
20	17552835-0	JOSÉ IGNACIO ANDRÉS FERNÁNDEZ GALLEGOS	jose.fernandez@epchinchorro.cl	t
21	15003307-1	ANGGIE ELIZABETH CASTILLO CARTER	anggie.castillo@epchinchorro.cl	t
22	13219634-6	LJUBICA DENISSE DEFINIS CASTILLO	ljubica.definis@epchinchorro.cl	t
23	14341517-1	FRESIA CAROLINA ARREDONDO DÍAZ	fresia.arredondo@epchinchorro.cl	t
24	9666841-4	IVAN ARANCIBIA MUÑOZ	ivan.arancibia@epchinchorro.cl	t
25	8290280-5	JUAN GUILLERMO JORDÁN ARIAS	juan.jordan@epchinchorro.cl	t
26	8568846-4	JACQUELINE DEL ROSARIO RETAMALES ESPINOZA	jacqueline.retamales@epchinchorro.cl	t
27	9648471-2	EMMA VASQUEZ ACUÑA	emma.vasquez@epchinchorro.cl	t
28	7627891-1	ORLANDO AMARO SANTIBÁÑEZ FERREIRA	orlando.santibanezfe@slepchinchorro.cl	t
29	15002172-3	JUAN ANTONIO ZAMORA BERRIOS	juan.zamora@epchinchorro.cl	t
30	7211902-9	JULIO ORLANDO VARGAS LOBOS	julio.vargas@epchinchorro.cl	t
31	10431970-K	CÉSAR ROY CASO CASO	cesar.caso@epchinchorro.cl	t
32	9954258-6	PAMELA LIDIA FIGUEROA PIZARRO	pamela.figueroa@epchinchorro.cl	t
33	7068874-3	RUTH DINI VALENZUELA	ruth.dini@epchinchorro.cl	t
34	6641819-7	MARIA ISABEL ALVAREZ HERNANDEZ	maria.alvarez@epchinchorro.cl	t
35	8806971-4	LUIS HERNAN BARNAO ASTUDILLO	luis.barnao@epchinchorro.cl	t
36	12833494-7	GABRIELA MARIA MARTINEZ LORETO	gabriela.martinez@epchinchorro.cl	t
37	10050423-5	RICHARD CLAUDIO MORALES CAMPUSANO	richard.morales@epchinchorro.cl	t
38	14103080-9	RAUL ADRIAN HUENTECURA CONDORI	raul.huentecura@epchinchorro.cl	t
39	9272619-3	ORIETA LORENA GARCIA ORE	orieta.garcia@epchinchorro.cl	t
40	13412492-K	IVONETT DEL PILAR BARRIOS JORQUERA	ivonett.barrios@epchinchorro.cl	t
41	12437652-1	MARIANELLA GOMEZ ALVARADO	marianella.gomez@epchinchorro.cl	t
42	12834843-3	MABEL JACQUELINE HIDALGO DÍAZ	ljubica.definis@epchinchorro.cl	t
43	13007009-4	MACARENA MILENKA CÁCERES ROMERO	macarena.caceres@epchinchorro.cl	t
44	10994717-2	LEONOR ELISA CAÑIPA PONCE	leonor.canipa@epchinchorro.cl	t
45	14104976-3	JOANA SYLVIA ESPINOZA VARGAS	joana.espinoza@epchinchorro.cl	t
46	14105096-6	CAROLINA ALEJANDRA DÍAZ VON FURSTENBERG	carolina.diaz@epchinchorro.cl	t
47	16225165-1	CARLA NAIR COFRÉ MÁNQUEZ	carla.cofre@epchinchorro.cl	t
48	8956041-1	PAOLA GEMITA PÉREZ PIZARRO	paola.perez@epchinchorro.cl	t
49	14103120-1	CAROLINA CRISTINA VALDEBENITO ZAMBRANO	carolina.valdebenito@epchinchorro.cl	t
50	10808456-1	DANIEL JUAN VILLEGAS HERRERA	daniel.villegas@epchinchorro.cl	t
51	9369989-0	RAÚL GONZALO VÁSQUEZ FLORES	raul.vasquez@epchinchorro.cl	t
52	6639275-9	LUIS RAMOS ÁLVAREZ	luis.ramos@epchinchorro.cl	t
53	15008543-8	ALVARO IVAN CAÑIPA PACHA	alvaro.canipa@epchinchorro.cl	t
54	10662941-2	RÓMULO PAUL MALDONADO ÁLVAREZ	romulo.maldonado@epchinchorro.cl	t
55	8285797-4	MARIO STEWARD GUTIERREZ CAÑIPA	mario.gutierrez@epchinchorro.cl	t
56	12611016-2	JHOEL CÁCERES ROMERO	jhoel.caceres@epchinchorro.cl	t
57	10019190-3	GIULLIA ANTONIETA OLIVERA LEON	giullia.olivera@epchinchorro.cl	t
58	19494122-6	JAIME DOMÉNICO EUGENIO APATA GALLEGOS	jaime.apata@epchinchorro.cl	t
59	14104621-7	MARJORIE PRISCILLA APAZ SAMIT	marjorie.apaz@epchinchorro.cl	t
60	9450061-3	LORELIA ZENIS OYARZO	lorelia.zenis@epchinchorro.cl	t
61	9640249-K	MARCELA ROJAS CASTRO	marcela.rojas@epchinchorro.cl	t
62	5769684-2	FERNANDO FERNÁNDEZ OLIVARES	fernando.fernandez@epchinchorro.cl	t
63	9475926-9	RENATO VALENTINO DEL ROSARIO BRITO GAVILÁN	renato.brito@epchinchorro.cl	t
64	7045842-K	MANUEL RIOS BENAVENTE	manuel.rios@epchinchorro.cl	t
65	11506485-1	MARIA ALICIA MUGUEÑO MUÑOZ	maria.mugueno@epchinchorro.cl	t
66	9284047-6	LUIS MERINO JARA	luis.merino@epchinchorro.cl	t
67	16911371-8	RODRIGO ANDRES FIERRO ACEITUNO	rodrigo.fierro@epchinchorro.cl	t
68	19493098-4	HANS IVAN GREGORIO BELTRAN	hans.gregorio@epchinchorro.cl	t
69	10500599-7	CARMEN CONDORE CALLE	carmen.condore@epchinchorro.cl	t
70	9331140-K	HUGO LLERENA PÉREZ	hugo.llerena@epchinchorro.cl	t
71	7665677-0	HÉCTOR CHOQUE SANTOS	hector.choque@epchinchorro.cl	t
\.


--
-- TOC entry 6004 (class 0 OID 19011)
-- Dependencies: 238
-- Data for Name: documentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documentos (id, nombre, fase_candidato) FROM stdin;
1	CURRICULUM VITAE	1
2	CERTIFICADO DE NACIMIENTO	2
3	FOTOCOPIA CÉDULA IDENTIDAD	1
4	CERTIFICADO AFILIACIÓN SISTEMA DE SALUD	2
5	CERTIFICADO DE AFILIACIÓN AFP	2
6	CERTIFICADO DE TÍTULO	1
7	CERTIFICADO DE INHABILIDADES PARA TRABAJAR CON MENORES DE EDAD	1
8	CERTIFICADO DE MALTRATO RELEVANTE	1
9	DECLARACIÓN JURADA SOBRE PENSIÓN DE ALIMENTOS	2
12	CERTIFICADO NACIMIENTO HIJOS	2
13	CERTIFICADO MATRIMONIO	2
14	CERTIFICADO APV	2
15	DECLARACIÓN JURADA SIMPLE	2
11	POSTÍTULO (opcional)	1
16	CERTIFICADO DE ANTECEDENTES PARA FINES ESPECIALES	1
17	CERTIFICADO DE EXPERIENCIA LABORAL (opcional)	1
\.


--
-- TOC entry 6005 (class 0 OID 19014)
-- Dependencies: 239
-- Data for Name: documentos_candidatos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documentos_candidatos (id, documento_id, candidato_id, ruta, nombre, created_at, nombre_para_mostrar) FROM stdin;
\.


--
-- TOC entry 6008 (class 0 OID 19021)
-- Dependencies: 242
-- Data for Name: estado_candidatos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado_candidatos (id, nombre) FROM stdin;
1	Nuevo
2	En revisión
3	Calificado
4	Descartado
\.


--
-- TOC entry 6041 (class 0 OID 20442)
-- Dependencies: 275
-- Data for Name: estado_carta_oferta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado_carta_oferta (id, nombre) FROM stdin;
1	creada
2	enviada al director
3	aprobada
4	anulada
\.


--
-- TOC entry 6010 (class 0 OID 19025)
-- Dependencies: 244
-- Data for Name: estado_convocatoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado_convocatoria (id, nombre) FROM stdin;
1	Nuevo
3	Queda 1 día
4	Finalizada
5	Proceso Cerrado
2	Abierta
\.


--
-- TOC entry 6012 (class 0 OID 19031)
-- Dependencies: 246
-- Data for Name: estados_civiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estados_civiles (id, nombre) FROM stdin;
1	Soltero
2	Casado
3	Divorciado
4	Viudo
\.


--
-- TOC entry 6014 (class 0 OID 19035)
-- Dependencies: 248
-- Data for Name: instituciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instituciones (id, nombre, correo, ciudad_id, director_id, activo) FROM stdin;
1	Centro de Capacitación Reino de Bélgica	ccl.belgica@epchinchorro.cl	1	7	t
2	Colegio Centenario Arica	esc.centenario@epchinchorro.cl	1	8	t
3	Colegio Integrado Eduardo Frei Montalva	lic.cief@epchinchorro.cl	1	5	t
4	Escuela Alcérreca	esc.alcerreca@epchinchorro.cl	1	\N	t
5	Escuela América (E-26)	esc.america@epchinchorro.cl	1	2	t
6	Escuela Ancolacane	esc.ancolacane@epchinchorro.cl	5	64	t
7	Escuela Carlos Condell de la Haza (G-8)	esc.ccondell@epchinchorro.cl	1	6	t
8	Escuela Chaca (G-55)	esc.chaca@epchinchorro.cl	6	9	t
9	Escuela Chislluma	esc.chislluma@epchinchorro.cl	5	68	t
10	Escuela Chujlluta	esc.chujlluta@epchinchorro.cl	4	69	t
11	Escuela Colpitas	esc.colpitas@epchinchorro.cl	4	71	t
12	Escuela Comandante Juan José San Martín (D-17)	esc.jjsanmartin@epchinchorro.cl	1	21	t
13	Escuela Cosapilla	esc.cosapilla@epchinchorro.cl	5	67	t
14	Escuela Cotacotani	esc.cotacotani@epchinchorro.cl	5	\N	t
15	Escuela Darío Salas (F-3)	esc.dariosalas@epchinchorro.cl	1	10	t
16	Escuela Doctor Ricardo Olea Guerra	esc.roleaguerra@epchinchorro.cl	1	34	t
17	Escuela El Marquez	esc.ticnamar@epchinchorro.cl	6	50	t
18	Escuela Esmeralda (E-5)	esc.esmeralda@epchinchorro.cl	1	11	t
19	Escuela España (G-28)	esc.espana@epchinchorro.cl	1	12	t
20	Escuela Gabriela Mistral (D-24)	esc.gmistral@epchinchorro.cl	1	11	t
21	Escuela General José Miguel Carrera (D-10)	esc.jmcarrera@epchinchorro.cl	1	19	t
22	Escuela General Manuel Baquedano (G-20)	esc.gbaquedano@epchinchorro.cl	1	13	t
23	Escuela General Pedro Lagos Marchant (D-7)	esc.glagos@epchinchorro.cl	1	14	t
24	Escuela Guacoyo	esc.guacoyo@epchinchorro.cl	5	70	t
25	Escuela Humberto Valenzuela García (D-18)	esc.hvalenzuelag@epchinchorro.cl	1	15	t
26	Escuela Humapalca	esc.humapalca@epchinchorro.cl	5	65	t
27	Escuela Ignacio Carrera Pinto (G-27)	esc.icarrerap@epchinchorro.cl	1	16	t
28	Escuela Internado de Visviri	esc.visviri@epchinchorro.cl	5	66	t
29	Escuela Jorge Alessandri Rodríguez	esc.jalessandrir@epchinchorro.cl	1	18	t
30	Escuela Los Álamos	esc.murmuntani@epchinchorro.cl	4	53	t
31	Escuela Manuel Rodríguez Erdoyza (D-11)	esc.mrodrigueze@epchinchorro.cl	1	23	t
32	Escuela Molinos (G-117)	esc.molinos@epchinchorro.cl	4	24	t
33	Escuela Pampa Algodonal (G-31)	esc.palgodonal@epchinchorro.cl	3	27	t
34	Escuela Payachatas	esc.payachatas@epchinchorro.cl	5	51	t
35	Escuela Pedro Gutiérrez Torres (E-93)	esc.pgutierrezt@epchinchorro.cl	1	28	t
36	Escuela Regimiento Rancagua (D-14)	esc.regrancagua@epchinchorro.cl	1	30	t
37	Escuela República Argentina (E-1)	esc.argentina@epchinchorro.cl	1	31	t
38	Escuela República de Francia (D-6)	esc.repfrancia@epchinchorro.cl	1	32	t
39	Escuela República de Israel (D-4)	esc.israel@epchinchorro.cl	1	33	t
40	Escuela Ricardo Silva Arriagada (E-15)	esc.rsilvaarriaguda@epchinchorro.cl	1	35	t
41	Escuela Rómulo Peña Maturana (D-12)	esc.rpenam@epchinchorro.cl	1	36	t
42	Escuela San Francisco de Asís	esc.franciscodeasis@epchinchorro.cl	1	52	t
43	Escuela San Santiago de Belén	esc.belen@epchinchorro.cl	5	55	t
44	Escuela Subteniente Luis Cruz Martínez (D-16)	esc.lcruzm@epchinchorro.cl	1	37	t
45	Escuela Tucapel (D-21)	esc.tucapel@epchinchorro.cl	1	38	t
46	Escuela Valle de Camarones	esc.vallecamarones@epchinchorro.cl	6	59	t
47	Escuela Valle de Chitita	esc.chitita@epchinchorro.cl	4	62	t
48	Escuela Valle de Cobija	esc.cobija@epchinchorro.cl	5	58	t
49	Escuela Valle de Codpa	lic.codpa@epchinchorro.cl	6	57	t
50	Escuela Valle de Cuya	esc.cuya@epchinchorro.cl	6	61	t
51	Escuela Valle de Esquiña	esc.esquina@epchinchorro.cl	6	56	t
52	Escuela Valle de Guañacagua	esc.guanacagua@epchinchorro.cl	5	60	t
53	Escuela Valle de Illapata	esc.illapata@epchinchorro.cl	5	63	t
54	Escuela Valle de Parcohaylla	esc.parcohaylla@epchinchorro.cl	5	\N	t
55	Instituto Comercial de Arica	lic.comercial@epchinchorro.cl	1	17	t
56	Jardín Infantil Arcoiris	jar.arcoiris@epchinchorro.cl	1	39	t
57	Jardín Infantil Caritas de Sol	jar.caritadesol@epchinchorro.cl	1	40	t
58	Jardín Infantil Estrellitas del Saber	jar.estrellitasdelsaber@epchinchorro.cl	1	41	t
59	Jardín Infantil Inti Jalsu	jar.intijalsu@epchinchorro.cl	1	49	t
60	Jardín Infantil Mazorquita	jar.mazorquita@epchinchorro.cl	1	48	t
61	Jardín Infantil Mi Rinconcito Feliz	jar.rinconcitofeliz@epchinchorro.cl	1	42	t
62	Jardín Infantil Mis Primeros Pasos	jar.primerospasos@epchinchorro.cl	1	43	t
63	Jardín Infantil Payachatas	jar.payachatas@epchinchorro.cl	5	44	t
64	Jardín Infantil Suma Panqaritas	jar.sumapanqaritas@epchinchorro.cl	1	46	t
65	Jardín Infantil Sueños de Angelitos	jar.suenosdeangelitos@epchinchorro.cl	1	45	t
66	Jardín Infantil Uruchi Amaya	jar.uruchiamaya@epchinchorro.cl	6	47	t
67	Liceo Agrícola José Abelardo Núñez	lic.agricolajan@epchinchorro.cl	3	1	t
68	Liceo Antonio Varas de la Barra (B-4)	lic.antoniovaras@epchinchorro.cl	1	3	t
69	Liceo Artístico Doctor Juan Noé Crevani	lic.artistico@epchinchorro.cl	1	4	t
70	Liceo Bicentenario Jovina Naranjo Fernández (A-5)	lic.jovinanaranjo@epchinchorro.cl	1	20	t
71	Liceo Bicentenario Pablo Neruda	lic.pabloneruda@epchinchorro.cl	1	26	t
72	Liceo Octavio Palma Pérez (A-1)	lic.opalmaperez@epchinchorro.cl	1	25	t
73	Liceo Politécnico (A-2)	lic.politecnico@epchinchorro.cl	1	29	t
74	Liceo Técnico Profesional Granaderos de Putre	lic.putre@epchinchorro.cl	2	54	t
75	Liceo Valle de Codpa	lic.codpa@epchinchorro.cl	6	57	t
\.


--
-- TOC entry 6016 (class 0 OID 19041)
-- Dependencies: 250
-- Data for Name: jornadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jornadas (id, nombre) FROM stdin;
4	Por Hora
1	Jornada Completa (44 Hrs.)
2	Jornada Parcial (menor a 22 Hrs.)
3	Media Jornada (22 Hrs.)
5	3/4 de Jornada (33Hrs)
\.


--
-- TOC entry 6018 (class 0 OID 19047)
-- Dependencies: 252
-- Data for Name: mensajes_web; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mensajes_web (id, nombre, correo, mensaje, rut, created_at, estado) FROM stdin;
\.


--
-- TOC entry 6020 (class 0 OID 19055)
-- Dependencies: 254
-- Data for Name: modalidades_horarias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modalidades_horarias (id, nombre) FROM stdin;
1	Jornada Escolar Completa
3	Jornada Vespertina / Nocturna
4	Jornadas Especiales o Flexibles
2	Media Jornada Escolar 
\.


--
-- TOC entry 6022 (class 0 OID 19061)
-- Dependencies: 256
-- Data for Name: nacionalidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nacionalidades (id, nombre) FROM stdin;
1	Chilena
2	Argentina
3	Peruana
4	Colombiana
5	Venezolana
6	Francesa
7	Cubana
8	Dominicana
9	Española
10	Ecuatoriana
11	Brasileña
12	Haitiana
13	Boliviana
14	Italiana
15	Alemana
16	Mexicana
17	Uruguaya
18	Estadounidense
19	Británica
20	Paraguaya
21	Canadiense
22	China (minoritaria)
\.


--
-- TOC entry 6024 (class 0 OID 19065)
-- Dependencies: 258
-- Data for Name: nivel_educacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nivel_educacion (id, nombre) FROM stdin;
1	Sin estudios formales
2	Educación básica / primaria incompleta
3	Educación básica / primaria completa
4	Educación media / secundaria incompleta
5	Educación media / secundaria completa
6	Educación técnico-profesional incompleta
7	Educación técnico-profesional completa
8	Educación universitaria incompleta
9	Educación universitaria completa
10	Postgrado incompleto (Diplomado/Magíster/Doctorado)
11	Postgrado completo (Diplomado/Magíster/Doctorado)
\.


--
-- TOC entry 6026 (class 0 OID 19069)
-- Dependencies: 260
-- Data for Name: postulaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.postulaciones (id, candidato_id, convocatoria_id, created_at, estado) FROM stdin;
1	3	1	2025-10-22 11:41:23.097769-03	f
2	1	1	2025-10-22 11:42:15.205771-03	f
\.


--
-- TOC entry 6028 (class 0 OID 19075)
-- Dependencies: 262
-- Data for Name: regiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regiones (id, nombre) FROM stdin;
1	Arica y Parinacota
2	Tarapacá
3	Antofagasta
4	Atacama
5	Coquimbo
6	Valparaíso
7	Metropolitana de Santiago
8	Libertador General Bernardo O'Higgins
9	Maule
10	Ñuble
11	Biobío
12	La Araucanía
13	Los Ríos
14	Los Lagos
15	Aysén del General Carlos Ibáñez del Campo
16	Magallanes y de la Antártica Chilena
\.


--
-- TOC entry 6030 (class 0 OID 19079)
-- Dependencies: 264
-- Data for Name: tipo_vacantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_vacantes (id, nombre) FROM stdin;
1	Cargo Vacante
2	Reemplazo
\.


--
-- TOC entry 6032 (class 0 OID 19085)
-- Dependencies: 266
-- Data for Name: titulos_profesionales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.titulos_profesionales (id, nombre) FROM stdin;
1	Asistente Social
2	Contador Auditor
3	Educación Parvularia
4	Enfermero(a)
5	Fonoaudiólogo
6	Ingeniero Civil en Minas
7	Ingeniero Comercial
8	Ingeniero de Ejecución en Minas
9	Ingeniero en Administración de Empresas
10	Ingeniero en Computación
11	Ingeniero en Construcción
12	Ingeniero Agrónomo
13	Ingeniero en Ejecución Mecánica
14	Ingeniero en Electrónica / Electricidad
15	Ingeniero en Informática
16	Ingeniero en Mecánica
17	Ingeniero en Metalurgia
18	Ingeniero Mecánico Automotriz
19	Kinesiólogo
20	Matrona
21	Profesor de Artes Visuales
22	Profesor de Educación Diferencial
23	Profesor de Educación Física
24	Profesor de Educación General Básica
25	Profesor de Educación Media en Biología
26	Profesor de Educación Media en Física
27	Profesor de Educación Media en Inglés
28	Profesor de Educación Media en Lenguaje y Comunicación
29	Profesor de Educación Media en Matemática
30	Profesor de Educación Media en Química
31	Profesor de Historia y Ciencias Sociales
32	Profesor de Música
33	Profesor General Básico con mención en Ciencias
34	Profesor General Básico con mención en Lenguaje
35	Profesor General Básico con mención en Matemática
36	Psicólogo
37	Psicopedagogo
38	Técnico de Nivel Superior en Electricidad
39	Técnico en Administración
40	Técnico en Deportes y Recreación
41	Técnico en Conectividad y Redes
42	Técnico en Educación Especial
43	Técnico en Enfermería
44	Técnico en Gastronomía
45	Técnico en Parvularia
46	Técnico en Turismo
47	Terapeuta Ocupacional
48	Trabajador Social
49	Director de Establecimiento Educacional
50	Inspector General
51	Jefe de Unidad Técnico Pedagógica (UTP)
52	Orientador Educacional
53	Coordinador PIE
54	Especialista en Currículum
55	Especialista en Evaluación Educativa
56	Gestor Educacional
57	Administrador Educacional
58	Coordinador de Convivencia Escolar
59	Especialista en Inclusión Educativa
60	Técnico en Bibliotecología
61	Asistente de la Educación
62	Monitor Educativo
63	Coordinador de Talleres Extraescolares
64	Especialista en Tecnología Educativa
65	Coordinador de Recursos Humanos en Educación
66	Especialista en Finanzas Educacionales
67	Coordinador de Infraestructura Escolar
68	Especialista en Mantenimiento de Establecimientos Educacionales
69	Técnico en Administración Educacional
70	Técnico en Trabajo Social
71	Técnico en Psicopedagogía
72	Técnico en Integración Social
73	Técnico en Atención de Párvulos
74	Técnico en Educación Básica
75	Técnico en Recreación y Deportes
76	Abogado
77	Administrador Público
78	Arquitecto
79	Asistente Administrativo
80	Auxiliar de Servicios
81	Bibliotecólogo
82	Comunicador Social
83	Community Manager
84	Diseñador Gráfico
85	Especialista en Compras Públicas
86	Especialista en Proyectos Educativos
87	Gestor Cultural
88	Prevencionista de Riesgos
89	Programador
90	Secretario Administrativo
91	Sociólogo
92	Otro (especificar)
\.


--
-- TOC entry 6034 (class 0 OID 19089)
-- Dependencies: 268
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, usuario, password, estado, created_at, rol, uid) FROM stdin;
3	16469777-0	$2b$10$wOIdEohRaI0eNFvcrVI7ROVkhC9X4Ol24jWnkW9S0eaLDjwCbaPQG	t	2025-10-22 11:24:38.898-03	user	f53ce587-701a-4107-8218-c634b6bfdc6e
4	12607595-2	$2b$10$C8Wp1RBDPGudOIuhR4z4c.NeKgdc7p34actwkd5H44oIuDT9bKnhC	t	2025-10-22 11:25:49.464-03	user	c6bdc5e6-f535-43e8-b6c9-18693b61c319
1	16467901-2	$2b$10$Y/rwzHN.OZsOv04.p5PuduYBYCgRroMnPOCTWShRlbKCg6xDzjApi	t	2025-10-22 11:09:50.84-03	admin	ddec413c-e7c2-4191-b33e-bfd8d45086a1
2	20217385-3	$2b$10$IJedtjCGkB5w5s7ZbchskuOKbJ/BnxCjP1YODIuoVXY9zcPzMlwbu	t	2025-10-22 11:12:57.16-03	reclutador	2f0105e2-090c-4f1a-91c3-8ca57b106489
\.


--
-- TOC entry 6078 (class 0 OID 0)
-- Dependencies: 220
-- Name: candidatos_ciudades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.candidatos_ciudades_id_seq', 2, true);


--
-- TOC entry 6079 (class 0 OID 0)
-- Dependencies: 221
-- Name: candidatos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.candidatos_id_seq', 4, true);


--
-- TOC entry 6080 (class 0 OID 0)
-- Dependencies: 223
-- Name: candidatos_jornadas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.candidatos_jornadas_id_seq', 2, true);


--
-- TOC entry 6081 (class 0 OID 0)
-- Dependencies: 225
-- Name: candidatos_modalidades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.candidatos_modalidades_id_seq', 1, true);


--
-- TOC entry 6082 (class 0 OID 0)
-- Dependencies: 227
-- Name: cargos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cargos_id_seq', 44, true);


--
-- TOC entry 6083 (class 0 OID 0)
-- Dependencies: 272
-- Name: cartas_ofertas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartas_ofertas_id_seq', 4, true);


--
-- TOC entry 6084 (class 0 OID 0)
-- Dependencies: 229
-- Name: categoria_cargos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_cargos_id_seq', 5, true);


--
-- TOC entry 6085 (class 0 OID 0)
-- Dependencies: 231
-- Name: ciudades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ciudades_id_seq', 7, true);


--
-- TOC entry 6086 (class 0 OID 0)
-- Dependencies: 233
-- Name: comentarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentarios_id_seq', 1, false);


--
-- TOC entry 6087 (class 0 OID 0)
-- Dependencies: 235
-- Name: comunas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comunas_id_seq', 345, true);


--
-- TOC entry 6088 (class 0 OID 0)
-- Dependencies: 237
-- Name: convocatorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.convocatorias_id_seq', 1, true);


--
-- TOC entry 6089 (class 0 OID 0)
-- Dependencies: 270
-- Name: directores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directores_id_seq', 71, true);


--
-- TOC entry 6090 (class 0 OID 0)
-- Dependencies: 240
-- Name: documentos_candidatos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documentos_candidatos_id_seq', 1, false);


--
-- TOC entry 6091 (class 0 OID 0)
-- Dependencies: 241
-- Name: documentos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documentos_id_seq', 17, true);


--
-- TOC entry 6092 (class 0 OID 0)
-- Dependencies: 243
-- Name: estado_candidatos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_candidatos_id_seq', 4, true);


--
-- TOC entry 6093 (class 0 OID 0)
-- Dependencies: 274
-- Name: estado_carta_oferta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_carta_oferta_id_seq', 4, true);


--
-- TOC entry 6094 (class 0 OID 0)
-- Dependencies: 245
-- Name: estado_convocatoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_convocatoria_id_seq', 5, true);


--
-- TOC entry 6095 (class 0 OID 0)
-- Dependencies: 247
-- Name: estados_civiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_civiles_id_seq', 4, true);


--
-- TOC entry 6096 (class 0 OID 0)
-- Dependencies: 249
-- Name: instituciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instituciones_id_seq', 1, false);


--
-- TOC entry 6097 (class 0 OID 0)
-- Dependencies: 251
-- Name: jornadas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jornadas_id_seq', 5, true);


--
-- TOC entry 6098 (class 0 OID 0)
-- Dependencies: 253
-- Name: mensajes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mensajes_id_seq', 1, false);


--
-- TOC entry 6099 (class 0 OID 0)
-- Dependencies: 255
-- Name: modalidades_horarias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modalidades_horarias_id_seq', 4, true);


--
-- TOC entry 6100 (class 0 OID 0)
-- Dependencies: 257
-- Name: nacionalidades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nacionalidades_id_seq', 22, true);


--
-- TOC entry 6101 (class 0 OID 0)
-- Dependencies: 259
-- Name: nivel_educacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nivel_educacion_id_seq', 11, true);


--
-- TOC entry 6102 (class 0 OID 0)
-- Dependencies: 261
-- Name: postulaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.postulaciones_id_seq', 2, true);


--
-- TOC entry 6103 (class 0 OID 0)
-- Dependencies: 263
-- Name: regiones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regiones_id_seq', 16, true);


--
-- TOC entry 6104 (class 0 OID 0)
-- Dependencies: 265
-- Name: tipo_vacante_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_vacante_id_seq', 2, true);


--
-- TOC entry 6105 (class 0 OID 0)
-- Dependencies: 267
-- Name: titulos_profesionales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.titulos_profesionales_id_seq', 92, true);


--
-- TOC entry 6106 (class 0 OID 0)
-- Dependencies: 269
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 4, true);


--
-- TOC entry 4938 (class 2606 OID 19123)
-- Name: candidatos_cargos candidatos_cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_cargos
    ADD CONSTRAINT candidatos_cargos_pkey PRIMARY KEY (candidato_id, cargo_id);


--
-- TOC entry 4940 (class 2606 OID 19125)
-- Name: candidatos_ciudades candidatos_ciudades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_ciudades
    ADD CONSTRAINT candidatos_ciudades_pkey PRIMARY KEY (id);


--
-- TOC entry 4929 (class 2606 OID 19127)
-- Name: candidatos candidatos_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_correo_key UNIQUE (correo);


--
-- TOC entry 4942 (class 2606 OID 19129)
-- Name: candidatos_jornadas candidatos_jornadas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_jornadas
    ADD CONSTRAINT candidatos_jornadas_pkey PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 19131)
-- Name: candidatos_modalidades candidatos_modalidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_modalidades
    ADD CONSTRAINT candidatos_modalidades_pkey PRIMARY KEY (id);


--
-- TOC entry 4931 (class 2606 OID 19133)
-- Name: candidatos candidatos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_pkey PRIMARY KEY (id);


--
-- TOC entry 4933 (class 2606 OID 19135)
-- Name: candidatos candidatos_rut_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_rut_key UNIQUE (rut);


--
-- TOC entry 4946 (class 2606 OID 19137)
-- Name: cargos cargos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_nombre_key UNIQUE (nombre);


--
-- TOC entry 4948 (class 2606 OID 19139)
-- Name: cargos cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (id);


--
-- TOC entry 5797 (class 2606 OID 20409)
-- Name: cartas_ofertas cartas_ofertas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartas_ofertas
    ADD CONSTRAINT cartas_ofertas_pkey PRIMARY KEY (id);


--
-- TOC entry 4950 (class 2606 OID 19141)
-- Name: categoria_cargos categoria_cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria_cargos
    ADD CONSTRAINT categoria_cargos_pkey PRIMARY KEY (id);


--
-- TOC entry 4952 (class 2606 OID 19143)
-- Name: ciudades ciudades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT ciudades_pkey PRIMARY KEY (id);


--
-- TOC entry 4954 (class 2606 OID 19145)
-- Name: comentarios comentarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT comentarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4956 (class 2606 OID 19147)
-- Name: comunas comunas_nombre_region_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comunas
    ADD CONSTRAINT comunas_nombre_region_id_key UNIQUE (nombre, region_id);


--
-- TOC entry 4958 (class 2606 OID 19149)
-- Name: comunas comunas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comunas
    ADD CONSTRAINT comunas_pkey PRIMARY KEY (id);


--
-- TOC entry 4961 (class 2606 OID 19151)
-- Name: convocatorias convocatorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_pkey PRIMARY KEY (id);


--
-- TOC entry 5795 (class 2606 OID 20130)
-- Name: directores directores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directores
    ADD CONSTRAINT directores_pkey PRIMARY KEY (id);


--
-- TOC entry 5053 (class 2606 OID 19153)
-- Name: documentos_candidatos documentos_candidatos_documento_id_candidato_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_candidatos
    ADD CONSTRAINT documentos_candidatos_documento_id_candidato_id_key UNIQUE (documento_id, candidato_id);


--
-- TOC entry 5055 (class 2606 OID 19155)
-- Name: documentos_candidatos documentos_candidatos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_candidatos
    ADD CONSTRAINT documentos_candidatos_pkey PRIMARY KEY (id);


--
-- TOC entry 4963 (class 2606 OID 19157)
-- Name: documentos documentos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key UNIQUE (nombre);


--
-- TOC entry 4965 (class 2606 OID 19159)
-- Name: documentos documentos_nombre_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key1 UNIQUE (nombre);


--
-- TOC entry 4967 (class 2606 OID 19161)
-- Name: documentos documentos_nombre_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key10 UNIQUE (nombre);


--
-- TOC entry 4969 (class 2606 OID 19163)
-- Name: documentos documentos_nombre_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key11 UNIQUE (nombre);


--
-- TOC entry 4971 (class 2606 OID 19165)
-- Name: documentos documentos_nombre_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key12 UNIQUE (nombre);


--
-- TOC entry 4973 (class 2606 OID 19167)
-- Name: documentos documentos_nombre_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key13 UNIQUE (nombre);


--
-- TOC entry 4975 (class 2606 OID 19169)
-- Name: documentos documentos_nombre_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key14 UNIQUE (nombre);


--
-- TOC entry 4977 (class 2606 OID 19171)
-- Name: documentos documentos_nombre_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key15 UNIQUE (nombre);


--
-- TOC entry 4979 (class 2606 OID 19173)
-- Name: documentos documentos_nombre_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key16 UNIQUE (nombre);


--
-- TOC entry 4981 (class 2606 OID 19175)
-- Name: documentos documentos_nombre_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key17 UNIQUE (nombre);


--
-- TOC entry 4983 (class 2606 OID 19177)
-- Name: documentos documentos_nombre_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key18 UNIQUE (nombre);


--
-- TOC entry 4985 (class 2606 OID 19179)
-- Name: documentos documentos_nombre_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key19 UNIQUE (nombre);


--
-- TOC entry 4987 (class 2606 OID 19181)
-- Name: documentos documentos_nombre_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key2 UNIQUE (nombre);


--
-- TOC entry 4989 (class 2606 OID 19183)
-- Name: documentos documentos_nombre_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key20 UNIQUE (nombre);


--
-- TOC entry 4991 (class 2606 OID 19185)
-- Name: documentos documentos_nombre_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key21 UNIQUE (nombre);


--
-- TOC entry 4993 (class 2606 OID 19187)
-- Name: documentos documentos_nombre_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key22 UNIQUE (nombre);


--
-- TOC entry 4995 (class 2606 OID 19189)
-- Name: documentos documentos_nombre_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key23 UNIQUE (nombre);


--
-- TOC entry 4997 (class 2606 OID 19191)
-- Name: documentos documentos_nombre_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key24 UNIQUE (nombre);


--
-- TOC entry 4999 (class 2606 OID 19193)
-- Name: documentos documentos_nombre_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key25 UNIQUE (nombre);


--
-- TOC entry 5001 (class 2606 OID 19195)
-- Name: documentos documentos_nombre_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key26 UNIQUE (nombre);


--
-- TOC entry 5003 (class 2606 OID 19197)
-- Name: documentos documentos_nombre_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key27 UNIQUE (nombre);


--
-- TOC entry 5005 (class 2606 OID 19199)
-- Name: documentos documentos_nombre_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key28 UNIQUE (nombre);


--
-- TOC entry 5007 (class 2606 OID 19201)
-- Name: documentos documentos_nombre_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key29 UNIQUE (nombre);


--
-- TOC entry 5009 (class 2606 OID 19203)
-- Name: documentos documentos_nombre_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key3 UNIQUE (nombre);


--
-- TOC entry 5011 (class 2606 OID 19205)
-- Name: documentos documentos_nombre_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key30 UNIQUE (nombre);


--
-- TOC entry 5013 (class 2606 OID 19207)
-- Name: documentos documentos_nombre_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key31 UNIQUE (nombre);


--
-- TOC entry 5015 (class 2606 OID 19209)
-- Name: documentos documentos_nombre_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key32 UNIQUE (nombre);


--
-- TOC entry 5017 (class 2606 OID 19211)
-- Name: documentos documentos_nombre_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key33 UNIQUE (nombre);


--
-- TOC entry 5019 (class 2606 OID 19213)
-- Name: documentos documentos_nombre_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key34 UNIQUE (nombre);


--
-- TOC entry 5021 (class 2606 OID 19215)
-- Name: documentos documentos_nombre_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key35 UNIQUE (nombre);


--
-- TOC entry 5023 (class 2606 OID 19217)
-- Name: documentos documentos_nombre_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key36 UNIQUE (nombre);


--
-- TOC entry 5025 (class 2606 OID 19219)
-- Name: documentos documentos_nombre_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key37 UNIQUE (nombre);


--
-- TOC entry 5027 (class 2606 OID 19221)
-- Name: documentos documentos_nombre_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key38 UNIQUE (nombre);


--
-- TOC entry 5029 (class 2606 OID 19223)
-- Name: documentos documentos_nombre_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key39 UNIQUE (nombre);


--
-- TOC entry 5031 (class 2606 OID 19225)
-- Name: documentos documentos_nombre_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key4 UNIQUE (nombre);


--
-- TOC entry 5033 (class 2606 OID 19227)
-- Name: documentos documentos_nombre_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key40 UNIQUE (nombre);


--
-- TOC entry 5035 (class 2606 OID 19229)
-- Name: documentos documentos_nombre_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key41 UNIQUE (nombre);


--
-- TOC entry 5037 (class 2606 OID 19231)
-- Name: documentos documentos_nombre_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key42 UNIQUE (nombre);


--
-- TOC entry 5039 (class 2606 OID 19233)
-- Name: documentos documentos_nombre_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key43 UNIQUE (nombre);


--
-- TOC entry 5041 (class 2606 OID 19235)
-- Name: documentos documentos_nombre_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key5 UNIQUE (nombre);


--
-- TOC entry 5043 (class 2606 OID 19237)
-- Name: documentos documentos_nombre_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key6 UNIQUE (nombre);


--
-- TOC entry 5045 (class 2606 OID 19239)
-- Name: documentos documentos_nombre_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key7 UNIQUE (nombre);


--
-- TOC entry 5047 (class 2606 OID 19241)
-- Name: documentos documentos_nombre_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key8 UNIQUE (nombre);


--
-- TOC entry 5049 (class 2606 OID 19243)
-- Name: documentos documentos_nombre_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_nombre_key9 UNIQUE (nombre);


--
-- TOC entry 5051 (class 2606 OID 19245)
-- Name: documentos documentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT documentos_pkey PRIMARY KEY (id);


--
-- TOC entry 5057 (class 2606 OID 19247)
-- Name: estado_candidatos estado_candidatos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key UNIQUE (nombre);


--
-- TOC entry 5059 (class 2606 OID 19249)
-- Name: estado_candidatos estado_candidatos_nombre_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key1 UNIQUE (nombre);


--
-- TOC entry 5061 (class 2606 OID 19251)
-- Name: estado_candidatos estado_candidatos_nombre_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key10 UNIQUE (nombre);


--
-- TOC entry 5063 (class 2606 OID 19253)
-- Name: estado_candidatos estado_candidatos_nombre_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key11 UNIQUE (nombre);


--
-- TOC entry 5065 (class 2606 OID 19255)
-- Name: estado_candidatos estado_candidatos_nombre_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key12 UNIQUE (nombre);


--
-- TOC entry 5067 (class 2606 OID 19257)
-- Name: estado_candidatos estado_candidatos_nombre_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key13 UNIQUE (nombre);


--
-- TOC entry 5069 (class 2606 OID 19259)
-- Name: estado_candidatos estado_candidatos_nombre_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key14 UNIQUE (nombre);


--
-- TOC entry 5071 (class 2606 OID 19261)
-- Name: estado_candidatos estado_candidatos_nombre_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key15 UNIQUE (nombre);


--
-- TOC entry 5073 (class 2606 OID 19263)
-- Name: estado_candidatos estado_candidatos_nombre_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key16 UNIQUE (nombre);


--
-- TOC entry 5075 (class 2606 OID 19265)
-- Name: estado_candidatos estado_candidatos_nombre_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key17 UNIQUE (nombre);


--
-- TOC entry 5077 (class 2606 OID 19267)
-- Name: estado_candidatos estado_candidatos_nombre_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key18 UNIQUE (nombre);


--
-- TOC entry 5079 (class 2606 OID 19269)
-- Name: estado_candidatos estado_candidatos_nombre_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key19 UNIQUE (nombre);


--
-- TOC entry 5081 (class 2606 OID 19271)
-- Name: estado_candidatos estado_candidatos_nombre_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key2 UNIQUE (nombre);


--
-- TOC entry 5083 (class 2606 OID 19273)
-- Name: estado_candidatos estado_candidatos_nombre_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key20 UNIQUE (nombre);


--
-- TOC entry 5085 (class 2606 OID 19275)
-- Name: estado_candidatos estado_candidatos_nombre_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key21 UNIQUE (nombre);


--
-- TOC entry 5087 (class 2606 OID 19277)
-- Name: estado_candidatos estado_candidatos_nombre_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key22 UNIQUE (nombre);


--
-- TOC entry 5089 (class 2606 OID 19279)
-- Name: estado_candidatos estado_candidatos_nombre_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key23 UNIQUE (nombre);


--
-- TOC entry 5091 (class 2606 OID 19281)
-- Name: estado_candidatos estado_candidatos_nombre_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key24 UNIQUE (nombre);


--
-- TOC entry 5093 (class 2606 OID 19283)
-- Name: estado_candidatos estado_candidatos_nombre_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key25 UNIQUE (nombre);


--
-- TOC entry 5095 (class 2606 OID 19285)
-- Name: estado_candidatos estado_candidatos_nombre_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key26 UNIQUE (nombre);


--
-- TOC entry 5097 (class 2606 OID 19287)
-- Name: estado_candidatos estado_candidatos_nombre_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key27 UNIQUE (nombre);


--
-- TOC entry 5099 (class 2606 OID 19289)
-- Name: estado_candidatos estado_candidatos_nombre_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key28 UNIQUE (nombre);


--
-- TOC entry 5101 (class 2606 OID 19291)
-- Name: estado_candidatos estado_candidatos_nombre_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key29 UNIQUE (nombre);


--
-- TOC entry 5103 (class 2606 OID 19293)
-- Name: estado_candidatos estado_candidatos_nombre_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key3 UNIQUE (nombre);


--
-- TOC entry 5105 (class 2606 OID 19295)
-- Name: estado_candidatos estado_candidatos_nombre_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key30 UNIQUE (nombre);


--
-- TOC entry 5107 (class 2606 OID 19297)
-- Name: estado_candidatos estado_candidatos_nombre_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key31 UNIQUE (nombre);


--
-- TOC entry 5109 (class 2606 OID 19299)
-- Name: estado_candidatos estado_candidatos_nombre_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key32 UNIQUE (nombre);


--
-- TOC entry 5111 (class 2606 OID 19301)
-- Name: estado_candidatos estado_candidatos_nombre_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key33 UNIQUE (nombre);


--
-- TOC entry 5113 (class 2606 OID 19303)
-- Name: estado_candidatos estado_candidatos_nombre_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key34 UNIQUE (nombre);


--
-- TOC entry 5115 (class 2606 OID 19305)
-- Name: estado_candidatos estado_candidatos_nombre_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key35 UNIQUE (nombre);


--
-- TOC entry 5117 (class 2606 OID 19307)
-- Name: estado_candidatos estado_candidatos_nombre_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key36 UNIQUE (nombre);


--
-- TOC entry 5119 (class 2606 OID 19309)
-- Name: estado_candidatos estado_candidatos_nombre_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key37 UNIQUE (nombre);


--
-- TOC entry 5121 (class 2606 OID 19311)
-- Name: estado_candidatos estado_candidatos_nombre_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key38 UNIQUE (nombre);


--
-- TOC entry 5123 (class 2606 OID 19313)
-- Name: estado_candidatos estado_candidatos_nombre_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key39 UNIQUE (nombre);


--
-- TOC entry 5125 (class 2606 OID 19315)
-- Name: estado_candidatos estado_candidatos_nombre_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key4 UNIQUE (nombre);


--
-- TOC entry 5127 (class 2606 OID 19317)
-- Name: estado_candidatos estado_candidatos_nombre_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key40 UNIQUE (nombre);


--
-- TOC entry 5129 (class 2606 OID 19319)
-- Name: estado_candidatos estado_candidatos_nombre_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key41 UNIQUE (nombre);


--
-- TOC entry 5131 (class 2606 OID 19321)
-- Name: estado_candidatos estado_candidatos_nombre_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key42 UNIQUE (nombre);


--
-- TOC entry 5133 (class 2606 OID 19323)
-- Name: estado_candidatos estado_candidatos_nombre_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key43 UNIQUE (nombre);


--
-- TOC entry 5135 (class 2606 OID 19325)
-- Name: estado_candidatos estado_candidatos_nombre_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key44 UNIQUE (nombre);


--
-- TOC entry 5137 (class 2606 OID 19327)
-- Name: estado_candidatos estado_candidatos_nombre_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key45 UNIQUE (nombre);


--
-- TOC entry 5139 (class 2606 OID 19329)
-- Name: estado_candidatos estado_candidatos_nombre_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key46 UNIQUE (nombre);


--
-- TOC entry 5141 (class 2606 OID 19331)
-- Name: estado_candidatos estado_candidatos_nombre_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key47 UNIQUE (nombre);


--
-- TOC entry 5143 (class 2606 OID 19333)
-- Name: estado_candidatos estado_candidatos_nombre_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key48 UNIQUE (nombre);


--
-- TOC entry 5145 (class 2606 OID 19335)
-- Name: estado_candidatos estado_candidatos_nombre_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key49 UNIQUE (nombre);


--
-- TOC entry 5147 (class 2606 OID 19337)
-- Name: estado_candidatos estado_candidatos_nombre_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key5 UNIQUE (nombre);


--
-- TOC entry 5149 (class 2606 OID 19339)
-- Name: estado_candidatos estado_candidatos_nombre_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key50 UNIQUE (nombre);


--
-- TOC entry 5151 (class 2606 OID 19341)
-- Name: estado_candidatos estado_candidatos_nombre_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key51 UNIQUE (nombre);


--
-- TOC entry 5153 (class 2606 OID 19343)
-- Name: estado_candidatos estado_candidatos_nombre_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key52 UNIQUE (nombre);


--
-- TOC entry 5155 (class 2606 OID 19345)
-- Name: estado_candidatos estado_candidatos_nombre_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key53 UNIQUE (nombre);


--
-- TOC entry 5157 (class 2606 OID 19347)
-- Name: estado_candidatos estado_candidatos_nombre_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key54 UNIQUE (nombre);


--
-- TOC entry 5159 (class 2606 OID 19349)
-- Name: estado_candidatos estado_candidatos_nombre_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key55 UNIQUE (nombre);


--
-- TOC entry 5161 (class 2606 OID 19351)
-- Name: estado_candidatos estado_candidatos_nombre_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key56 UNIQUE (nombre);


--
-- TOC entry 5163 (class 2606 OID 19353)
-- Name: estado_candidatos estado_candidatos_nombre_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key57 UNIQUE (nombre);


--
-- TOC entry 5165 (class 2606 OID 19355)
-- Name: estado_candidatos estado_candidatos_nombre_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key58 UNIQUE (nombre);


--
-- TOC entry 5167 (class 2606 OID 19357)
-- Name: estado_candidatos estado_candidatos_nombre_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key59 UNIQUE (nombre);


--
-- TOC entry 5169 (class 2606 OID 19359)
-- Name: estado_candidatos estado_candidatos_nombre_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key6 UNIQUE (nombre);


--
-- TOC entry 5171 (class 2606 OID 19361)
-- Name: estado_candidatos estado_candidatos_nombre_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key60 UNIQUE (nombre);


--
-- TOC entry 5173 (class 2606 OID 19363)
-- Name: estado_candidatos estado_candidatos_nombre_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key61 UNIQUE (nombre);


--
-- TOC entry 5175 (class 2606 OID 19365)
-- Name: estado_candidatos estado_candidatos_nombre_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key62 UNIQUE (nombre);


--
-- TOC entry 5177 (class 2606 OID 19367)
-- Name: estado_candidatos estado_candidatos_nombre_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key63 UNIQUE (nombre);


--
-- TOC entry 5179 (class 2606 OID 19369)
-- Name: estado_candidatos estado_candidatos_nombre_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key64 UNIQUE (nombre);


--
-- TOC entry 5181 (class 2606 OID 19371)
-- Name: estado_candidatos estado_candidatos_nombre_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key65 UNIQUE (nombre);


--
-- TOC entry 5183 (class 2606 OID 19373)
-- Name: estado_candidatos estado_candidatos_nombre_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key66 UNIQUE (nombre);


--
-- TOC entry 5185 (class 2606 OID 19375)
-- Name: estado_candidatos estado_candidatos_nombre_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key67 UNIQUE (nombre);


--
-- TOC entry 5187 (class 2606 OID 19377)
-- Name: estado_candidatos estado_candidatos_nombre_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key68 UNIQUE (nombre);


--
-- TOC entry 5189 (class 2606 OID 19379)
-- Name: estado_candidatos estado_candidatos_nombre_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key69 UNIQUE (nombre);


--
-- TOC entry 5191 (class 2606 OID 19381)
-- Name: estado_candidatos estado_candidatos_nombre_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key7 UNIQUE (nombre);


--
-- TOC entry 5193 (class 2606 OID 19383)
-- Name: estado_candidatos estado_candidatos_nombre_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key70 UNIQUE (nombre);


--
-- TOC entry 5195 (class 2606 OID 19385)
-- Name: estado_candidatos estado_candidatos_nombre_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key8 UNIQUE (nombre);


--
-- TOC entry 5197 (class 2606 OID 19387)
-- Name: estado_candidatos estado_candidatos_nombre_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_nombre_key9 UNIQUE (nombre);


--
-- TOC entry 5199 (class 2606 OID 19389)
-- Name: estado_candidatos estado_candidatos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_candidatos
    ADD CONSTRAINT estado_candidatos_pkey PRIMARY KEY (id);


--
-- TOC entry 5799 (class 2606 OID 20449)
-- Name: estado_carta_oferta estado_carta_oferta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_carta_oferta
    ADD CONSTRAINT estado_carta_oferta_pkey PRIMARY KEY (id);


--
-- TOC entry 5201 (class 2606 OID 19391)
-- Name: estado_convocatoria estado_convocatoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_convocatoria
    ADD CONSTRAINT estado_convocatoria_pkey PRIMARY KEY (id);


--
-- TOC entry 5203 (class 2606 OID 19393)
-- Name: estados_civiles estados_civiles_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key UNIQUE (nombre);


--
-- TOC entry 5205 (class 2606 OID 19395)
-- Name: estados_civiles estados_civiles_nombre_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key1 UNIQUE (nombre);


--
-- TOC entry 5207 (class 2606 OID 19397)
-- Name: estados_civiles estados_civiles_nombre_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key10 UNIQUE (nombre);


--
-- TOC entry 5209 (class 2606 OID 19399)
-- Name: estados_civiles estados_civiles_nombre_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key11 UNIQUE (nombre);


--
-- TOC entry 5211 (class 2606 OID 19401)
-- Name: estados_civiles estados_civiles_nombre_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key12 UNIQUE (nombre);


--
-- TOC entry 5213 (class 2606 OID 19403)
-- Name: estados_civiles estados_civiles_nombre_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key13 UNIQUE (nombre);


--
-- TOC entry 5215 (class 2606 OID 19405)
-- Name: estados_civiles estados_civiles_nombre_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key14 UNIQUE (nombre);


--
-- TOC entry 5217 (class 2606 OID 19407)
-- Name: estados_civiles estados_civiles_nombre_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key15 UNIQUE (nombre);


--
-- TOC entry 5219 (class 2606 OID 19409)
-- Name: estados_civiles estados_civiles_nombre_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key16 UNIQUE (nombre);


--
-- TOC entry 5221 (class 2606 OID 19411)
-- Name: estados_civiles estados_civiles_nombre_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key17 UNIQUE (nombre);


--
-- TOC entry 5223 (class 2606 OID 19413)
-- Name: estados_civiles estados_civiles_nombre_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key18 UNIQUE (nombre);


--
-- TOC entry 5225 (class 2606 OID 19415)
-- Name: estados_civiles estados_civiles_nombre_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key19 UNIQUE (nombre);


--
-- TOC entry 5227 (class 2606 OID 19417)
-- Name: estados_civiles estados_civiles_nombre_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key2 UNIQUE (nombre);


--
-- TOC entry 5229 (class 2606 OID 19419)
-- Name: estados_civiles estados_civiles_nombre_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key20 UNIQUE (nombre);


--
-- TOC entry 5231 (class 2606 OID 19421)
-- Name: estados_civiles estados_civiles_nombre_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key21 UNIQUE (nombre);


--
-- TOC entry 5233 (class 2606 OID 19423)
-- Name: estados_civiles estados_civiles_nombre_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key22 UNIQUE (nombre);


--
-- TOC entry 5235 (class 2606 OID 19425)
-- Name: estados_civiles estados_civiles_nombre_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key23 UNIQUE (nombre);


--
-- TOC entry 5237 (class 2606 OID 19427)
-- Name: estados_civiles estados_civiles_nombre_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key24 UNIQUE (nombre);


--
-- TOC entry 5239 (class 2606 OID 19429)
-- Name: estados_civiles estados_civiles_nombre_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key25 UNIQUE (nombre);


--
-- TOC entry 5241 (class 2606 OID 19431)
-- Name: estados_civiles estados_civiles_nombre_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key26 UNIQUE (nombre);


--
-- TOC entry 5243 (class 2606 OID 19433)
-- Name: estados_civiles estados_civiles_nombre_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key27 UNIQUE (nombre);


--
-- TOC entry 5245 (class 2606 OID 19435)
-- Name: estados_civiles estados_civiles_nombre_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key28 UNIQUE (nombre);


--
-- TOC entry 5247 (class 2606 OID 19437)
-- Name: estados_civiles estados_civiles_nombre_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key29 UNIQUE (nombre);


--
-- TOC entry 5249 (class 2606 OID 19439)
-- Name: estados_civiles estados_civiles_nombre_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key3 UNIQUE (nombre);


--
-- TOC entry 5251 (class 2606 OID 19441)
-- Name: estados_civiles estados_civiles_nombre_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key30 UNIQUE (nombre);


--
-- TOC entry 5253 (class 2606 OID 19443)
-- Name: estados_civiles estados_civiles_nombre_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key31 UNIQUE (nombre);


--
-- TOC entry 5255 (class 2606 OID 19445)
-- Name: estados_civiles estados_civiles_nombre_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key32 UNIQUE (nombre);


--
-- TOC entry 5257 (class 2606 OID 19447)
-- Name: estados_civiles estados_civiles_nombre_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key33 UNIQUE (nombre);


--
-- TOC entry 5259 (class 2606 OID 19449)
-- Name: estados_civiles estados_civiles_nombre_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key34 UNIQUE (nombre);


--
-- TOC entry 5261 (class 2606 OID 19451)
-- Name: estados_civiles estados_civiles_nombre_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key35 UNIQUE (nombre);


--
-- TOC entry 5263 (class 2606 OID 19453)
-- Name: estados_civiles estados_civiles_nombre_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key36 UNIQUE (nombre);


--
-- TOC entry 5265 (class 2606 OID 19455)
-- Name: estados_civiles estados_civiles_nombre_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key37 UNIQUE (nombre);


--
-- TOC entry 5267 (class 2606 OID 19457)
-- Name: estados_civiles estados_civiles_nombre_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key38 UNIQUE (nombre);


--
-- TOC entry 5269 (class 2606 OID 19459)
-- Name: estados_civiles estados_civiles_nombre_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key39 UNIQUE (nombre);


--
-- TOC entry 5271 (class 2606 OID 19461)
-- Name: estados_civiles estados_civiles_nombre_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key4 UNIQUE (nombre);


--
-- TOC entry 5273 (class 2606 OID 19463)
-- Name: estados_civiles estados_civiles_nombre_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key40 UNIQUE (nombre);


--
-- TOC entry 5275 (class 2606 OID 19465)
-- Name: estados_civiles estados_civiles_nombre_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key41 UNIQUE (nombre);


--
-- TOC entry 5277 (class 2606 OID 19467)
-- Name: estados_civiles estados_civiles_nombre_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key42 UNIQUE (nombre);


--
-- TOC entry 5279 (class 2606 OID 19469)
-- Name: estados_civiles estados_civiles_nombre_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key43 UNIQUE (nombre);


--
-- TOC entry 5281 (class 2606 OID 19471)
-- Name: estados_civiles estados_civiles_nombre_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key44 UNIQUE (nombre);


--
-- TOC entry 5283 (class 2606 OID 19473)
-- Name: estados_civiles estados_civiles_nombre_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key45 UNIQUE (nombre);


--
-- TOC entry 5285 (class 2606 OID 19475)
-- Name: estados_civiles estados_civiles_nombre_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key46 UNIQUE (nombre);


--
-- TOC entry 5287 (class 2606 OID 19477)
-- Name: estados_civiles estados_civiles_nombre_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key47 UNIQUE (nombre);


--
-- TOC entry 5289 (class 2606 OID 19479)
-- Name: estados_civiles estados_civiles_nombre_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key48 UNIQUE (nombre);


--
-- TOC entry 5291 (class 2606 OID 19481)
-- Name: estados_civiles estados_civiles_nombre_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key49 UNIQUE (nombre);


--
-- TOC entry 5293 (class 2606 OID 19483)
-- Name: estados_civiles estados_civiles_nombre_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key5 UNIQUE (nombre);


--
-- TOC entry 5295 (class 2606 OID 19485)
-- Name: estados_civiles estados_civiles_nombre_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key50 UNIQUE (nombre);


--
-- TOC entry 5297 (class 2606 OID 19487)
-- Name: estados_civiles estados_civiles_nombre_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key51 UNIQUE (nombre);


--
-- TOC entry 5299 (class 2606 OID 19489)
-- Name: estados_civiles estados_civiles_nombre_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key52 UNIQUE (nombre);


--
-- TOC entry 5301 (class 2606 OID 19491)
-- Name: estados_civiles estados_civiles_nombre_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key53 UNIQUE (nombre);


--
-- TOC entry 5303 (class 2606 OID 19493)
-- Name: estados_civiles estados_civiles_nombre_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key54 UNIQUE (nombre);


--
-- TOC entry 5305 (class 2606 OID 19495)
-- Name: estados_civiles estados_civiles_nombre_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key55 UNIQUE (nombre);


--
-- TOC entry 5307 (class 2606 OID 19497)
-- Name: estados_civiles estados_civiles_nombre_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key56 UNIQUE (nombre);


--
-- TOC entry 5309 (class 2606 OID 19499)
-- Name: estados_civiles estados_civiles_nombre_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key57 UNIQUE (nombre);


--
-- TOC entry 5311 (class 2606 OID 19501)
-- Name: estados_civiles estados_civiles_nombre_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key58 UNIQUE (nombre);


--
-- TOC entry 5313 (class 2606 OID 19503)
-- Name: estados_civiles estados_civiles_nombre_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key59 UNIQUE (nombre);


--
-- TOC entry 5315 (class 2606 OID 19505)
-- Name: estados_civiles estados_civiles_nombre_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key6 UNIQUE (nombre);


--
-- TOC entry 5317 (class 2606 OID 19507)
-- Name: estados_civiles estados_civiles_nombre_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key60 UNIQUE (nombre);


--
-- TOC entry 5319 (class 2606 OID 19509)
-- Name: estados_civiles estados_civiles_nombre_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key61 UNIQUE (nombre);


--
-- TOC entry 5321 (class 2606 OID 19511)
-- Name: estados_civiles estados_civiles_nombre_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key62 UNIQUE (nombre);


--
-- TOC entry 5323 (class 2606 OID 19513)
-- Name: estados_civiles estados_civiles_nombre_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key63 UNIQUE (nombre);


--
-- TOC entry 5325 (class 2606 OID 19515)
-- Name: estados_civiles estados_civiles_nombre_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key64 UNIQUE (nombre);


--
-- TOC entry 5327 (class 2606 OID 19517)
-- Name: estados_civiles estados_civiles_nombre_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key65 UNIQUE (nombre);


--
-- TOC entry 5329 (class 2606 OID 19519)
-- Name: estados_civiles estados_civiles_nombre_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key66 UNIQUE (nombre);


--
-- TOC entry 5331 (class 2606 OID 19521)
-- Name: estados_civiles estados_civiles_nombre_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key67 UNIQUE (nombre);


--
-- TOC entry 5333 (class 2606 OID 19523)
-- Name: estados_civiles estados_civiles_nombre_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key68 UNIQUE (nombre);


--
-- TOC entry 5335 (class 2606 OID 19525)
-- Name: estados_civiles estados_civiles_nombre_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key69 UNIQUE (nombre);


--
-- TOC entry 5337 (class 2606 OID 19527)
-- Name: estados_civiles estados_civiles_nombre_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key7 UNIQUE (nombre);


--
-- TOC entry 5339 (class 2606 OID 19529)
-- Name: estados_civiles estados_civiles_nombre_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key70 UNIQUE (nombre);


--
-- TOC entry 5341 (class 2606 OID 19531)
-- Name: estados_civiles estados_civiles_nombre_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key8 UNIQUE (nombre);


--
-- TOC entry 5343 (class 2606 OID 19533)
-- Name: estados_civiles estados_civiles_nombre_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_nombre_key9 UNIQUE (nombre);


--
-- TOC entry 5345 (class 2606 OID 19535)
-- Name: estados_civiles estados_civiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_civiles
    ADD CONSTRAINT estados_civiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5347 (class 2606 OID 19537)
-- Name: instituciones instituciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instituciones
    ADD CONSTRAINT instituciones_pkey PRIMARY KEY (id);


--
-- TOC entry 5349 (class 2606 OID 19539)
-- Name: jornadas jornadas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jornadas
    ADD CONSTRAINT jornadas_pkey PRIMARY KEY (id);


--
-- TOC entry 5351 (class 2606 OID 19541)
-- Name: mensajes_web mensajes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mensajes_web
    ADD CONSTRAINT mensajes_pkey PRIMARY KEY (id);


--
-- TOC entry 5353 (class 2606 OID 19543)
-- Name: modalidades_horarias modalidades_horarias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modalidades_horarias
    ADD CONSTRAINT modalidades_horarias_pkey PRIMARY KEY (id);


--
-- TOC entry 5355 (class 2606 OID 19545)
-- Name: nacionalidades nacionalidades_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key UNIQUE (nombre);


--
-- TOC entry 5357 (class 2606 OID 19547)
-- Name: nacionalidades nacionalidades_nombre_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key1 UNIQUE (nombre);


--
-- TOC entry 5359 (class 2606 OID 19549)
-- Name: nacionalidades nacionalidades_nombre_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key10 UNIQUE (nombre);


--
-- TOC entry 5361 (class 2606 OID 19551)
-- Name: nacionalidades nacionalidades_nombre_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key11 UNIQUE (nombre);


--
-- TOC entry 5363 (class 2606 OID 19553)
-- Name: nacionalidades nacionalidades_nombre_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key12 UNIQUE (nombre);


--
-- TOC entry 5365 (class 2606 OID 19555)
-- Name: nacionalidades nacionalidades_nombre_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key13 UNIQUE (nombre);


--
-- TOC entry 5367 (class 2606 OID 19557)
-- Name: nacionalidades nacionalidades_nombre_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key14 UNIQUE (nombre);


--
-- TOC entry 5369 (class 2606 OID 19559)
-- Name: nacionalidades nacionalidades_nombre_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key15 UNIQUE (nombre);


--
-- TOC entry 5371 (class 2606 OID 19561)
-- Name: nacionalidades nacionalidades_nombre_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key16 UNIQUE (nombre);


--
-- TOC entry 5373 (class 2606 OID 19563)
-- Name: nacionalidades nacionalidades_nombre_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key17 UNIQUE (nombre);


--
-- TOC entry 5375 (class 2606 OID 19565)
-- Name: nacionalidades nacionalidades_nombre_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key18 UNIQUE (nombre);


--
-- TOC entry 5377 (class 2606 OID 19567)
-- Name: nacionalidades nacionalidades_nombre_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key19 UNIQUE (nombre);


--
-- TOC entry 5379 (class 2606 OID 19569)
-- Name: nacionalidades nacionalidades_nombre_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key2 UNIQUE (nombre);


--
-- TOC entry 5381 (class 2606 OID 19571)
-- Name: nacionalidades nacionalidades_nombre_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key20 UNIQUE (nombre);


--
-- TOC entry 5383 (class 2606 OID 19573)
-- Name: nacionalidades nacionalidades_nombre_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key21 UNIQUE (nombre);


--
-- TOC entry 5385 (class 2606 OID 19575)
-- Name: nacionalidades nacionalidades_nombre_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key22 UNIQUE (nombre);


--
-- TOC entry 5387 (class 2606 OID 19577)
-- Name: nacionalidades nacionalidades_nombre_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key23 UNIQUE (nombre);


--
-- TOC entry 5389 (class 2606 OID 19579)
-- Name: nacionalidades nacionalidades_nombre_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key24 UNIQUE (nombre);


--
-- TOC entry 5391 (class 2606 OID 19581)
-- Name: nacionalidades nacionalidades_nombre_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key25 UNIQUE (nombre);


--
-- TOC entry 5393 (class 2606 OID 19583)
-- Name: nacionalidades nacionalidades_nombre_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key26 UNIQUE (nombre);


--
-- TOC entry 5395 (class 2606 OID 19585)
-- Name: nacionalidades nacionalidades_nombre_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key27 UNIQUE (nombre);


--
-- TOC entry 5397 (class 2606 OID 19587)
-- Name: nacionalidades nacionalidades_nombre_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key28 UNIQUE (nombre);


--
-- TOC entry 5399 (class 2606 OID 19589)
-- Name: nacionalidades nacionalidades_nombre_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key29 UNIQUE (nombre);


--
-- TOC entry 5401 (class 2606 OID 19591)
-- Name: nacionalidades nacionalidades_nombre_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key3 UNIQUE (nombre);


--
-- TOC entry 5403 (class 2606 OID 19593)
-- Name: nacionalidades nacionalidades_nombre_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key30 UNIQUE (nombre);


--
-- TOC entry 5405 (class 2606 OID 19595)
-- Name: nacionalidades nacionalidades_nombre_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key31 UNIQUE (nombre);


--
-- TOC entry 5407 (class 2606 OID 19597)
-- Name: nacionalidades nacionalidades_nombre_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key32 UNIQUE (nombre);


--
-- TOC entry 5409 (class 2606 OID 19599)
-- Name: nacionalidades nacionalidades_nombre_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key33 UNIQUE (nombre);


--
-- TOC entry 5411 (class 2606 OID 19601)
-- Name: nacionalidades nacionalidades_nombre_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key34 UNIQUE (nombre);


--
-- TOC entry 5413 (class 2606 OID 19603)
-- Name: nacionalidades nacionalidades_nombre_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key35 UNIQUE (nombre);


--
-- TOC entry 5415 (class 2606 OID 19605)
-- Name: nacionalidades nacionalidades_nombre_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key36 UNIQUE (nombre);


--
-- TOC entry 5417 (class 2606 OID 19607)
-- Name: nacionalidades nacionalidades_nombre_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key37 UNIQUE (nombre);


--
-- TOC entry 5419 (class 2606 OID 19609)
-- Name: nacionalidades nacionalidades_nombre_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key38 UNIQUE (nombre);


--
-- TOC entry 5421 (class 2606 OID 19611)
-- Name: nacionalidades nacionalidades_nombre_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key39 UNIQUE (nombre);


--
-- TOC entry 5423 (class 2606 OID 19613)
-- Name: nacionalidades nacionalidades_nombre_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key4 UNIQUE (nombre);


--
-- TOC entry 5425 (class 2606 OID 19615)
-- Name: nacionalidades nacionalidades_nombre_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key40 UNIQUE (nombre);


--
-- TOC entry 5427 (class 2606 OID 19617)
-- Name: nacionalidades nacionalidades_nombre_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key41 UNIQUE (nombre);


--
-- TOC entry 5429 (class 2606 OID 19619)
-- Name: nacionalidades nacionalidades_nombre_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key42 UNIQUE (nombre);


--
-- TOC entry 5431 (class 2606 OID 19621)
-- Name: nacionalidades nacionalidades_nombre_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key43 UNIQUE (nombre);


--
-- TOC entry 5433 (class 2606 OID 19623)
-- Name: nacionalidades nacionalidades_nombre_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key44 UNIQUE (nombre);


--
-- TOC entry 5435 (class 2606 OID 19625)
-- Name: nacionalidades nacionalidades_nombre_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key45 UNIQUE (nombre);


--
-- TOC entry 5437 (class 2606 OID 19627)
-- Name: nacionalidades nacionalidades_nombre_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key46 UNIQUE (nombre);


--
-- TOC entry 5439 (class 2606 OID 19629)
-- Name: nacionalidades nacionalidades_nombre_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key47 UNIQUE (nombre);


--
-- TOC entry 5441 (class 2606 OID 19631)
-- Name: nacionalidades nacionalidades_nombre_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key48 UNIQUE (nombre);


--
-- TOC entry 5443 (class 2606 OID 19633)
-- Name: nacionalidades nacionalidades_nombre_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key49 UNIQUE (nombre);


--
-- TOC entry 5445 (class 2606 OID 19635)
-- Name: nacionalidades nacionalidades_nombre_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key5 UNIQUE (nombre);


--
-- TOC entry 5447 (class 2606 OID 19637)
-- Name: nacionalidades nacionalidades_nombre_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key50 UNIQUE (nombre);


--
-- TOC entry 5449 (class 2606 OID 19639)
-- Name: nacionalidades nacionalidades_nombre_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key51 UNIQUE (nombre);


--
-- TOC entry 5451 (class 2606 OID 19641)
-- Name: nacionalidades nacionalidades_nombre_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key52 UNIQUE (nombre);


--
-- TOC entry 5453 (class 2606 OID 19643)
-- Name: nacionalidades nacionalidades_nombre_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key53 UNIQUE (nombre);


--
-- TOC entry 5455 (class 2606 OID 19645)
-- Name: nacionalidades nacionalidades_nombre_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key54 UNIQUE (nombre);


--
-- TOC entry 5457 (class 2606 OID 19647)
-- Name: nacionalidades nacionalidades_nombre_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key55 UNIQUE (nombre);


--
-- TOC entry 5459 (class 2606 OID 19649)
-- Name: nacionalidades nacionalidades_nombre_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key56 UNIQUE (nombre);


--
-- TOC entry 5461 (class 2606 OID 19651)
-- Name: nacionalidades nacionalidades_nombre_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key57 UNIQUE (nombre);


--
-- TOC entry 5463 (class 2606 OID 19653)
-- Name: nacionalidades nacionalidades_nombre_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key58 UNIQUE (nombre);


--
-- TOC entry 5465 (class 2606 OID 19655)
-- Name: nacionalidades nacionalidades_nombre_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key59 UNIQUE (nombre);


--
-- TOC entry 5467 (class 2606 OID 19657)
-- Name: nacionalidades nacionalidades_nombre_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key6 UNIQUE (nombre);


--
-- TOC entry 5469 (class 2606 OID 19659)
-- Name: nacionalidades nacionalidades_nombre_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key60 UNIQUE (nombre);


--
-- TOC entry 5471 (class 2606 OID 19661)
-- Name: nacionalidades nacionalidades_nombre_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key61 UNIQUE (nombre);


--
-- TOC entry 5473 (class 2606 OID 19663)
-- Name: nacionalidades nacionalidades_nombre_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key62 UNIQUE (nombre);


--
-- TOC entry 5475 (class 2606 OID 19665)
-- Name: nacionalidades nacionalidades_nombre_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key63 UNIQUE (nombre);


--
-- TOC entry 5477 (class 2606 OID 19667)
-- Name: nacionalidades nacionalidades_nombre_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key64 UNIQUE (nombre);


--
-- TOC entry 5479 (class 2606 OID 19669)
-- Name: nacionalidades nacionalidades_nombre_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key65 UNIQUE (nombre);


--
-- TOC entry 5481 (class 2606 OID 19671)
-- Name: nacionalidades nacionalidades_nombre_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key66 UNIQUE (nombre);


--
-- TOC entry 5483 (class 2606 OID 19673)
-- Name: nacionalidades nacionalidades_nombre_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key67 UNIQUE (nombre);


--
-- TOC entry 5485 (class 2606 OID 19675)
-- Name: nacionalidades nacionalidades_nombre_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key68 UNIQUE (nombre);


--
-- TOC entry 5487 (class 2606 OID 19677)
-- Name: nacionalidades nacionalidades_nombre_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key69 UNIQUE (nombre);


--
-- TOC entry 5489 (class 2606 OID 19679)
-- Name: nacionalidades nacionalidades_nombre_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key7 UNIQUE (nombre);


--
-- TOC entry 5491 (class 2606 OID 19681)
-- Name: nacionalidades nacionalidades_nombre_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key70 UNIQUE (nombre);


--
-- TOC entry 5493 (class 2606 OID 19683)
-- Name: nacionalidades nacionalidades_nombre_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key8 UNIQUE (nombre);


--
-- TOC entry 5495 (class 2606 OID 19685)
-- Name: nacionalidades nacionalidades_nombre_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_nombre_key9 UNIQUE (nombre);


--
-- TOC entry 5497 (class 2606 OID 19687)
-- Name: nacionalidades nacionalidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidades
    ADD CONSTRAINT nacionalidades_pkey PRIMARY KEY (id);


--
-- TOC entry 5499 (class 2606 OID 19689)
-- Name: nivel_educacion nivel_educacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_educacion
    ADD CONSTRAINT nivel_educacion_pkey PRIMARY KEY (id);


--
-- TOC entry 5501 (class 2606 OID 19691)
-- Name: postulaciones postulaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postulaciones
    ADD CONSTRAINT postulaciones_pkey PRIMARY KEY (id);


--
-- TOC entry 5503 (class 2606 OID 19693)
-- Name: regiones regiones_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key UNIQUE (nombre);


--
-- TOC entry 5505 (class 2606 OID 19695)
-- Name: regiones regiones_nombre_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key1 UNIQUE (nombre);


--
-- TOC entry 5507 (class 2606 OID 19697)
-- Name: regiones regiones_nombre_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key10 UNIQUE (nombre);


--
-- TOC entry 5509 (class 2606 OID 19699)
-- Name: regiones regiones_nombre_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key11 UNIQUE (nombre);


--
-- TOC entry 5511 (class 2606 OID 19701)
-- Name: regiones regiones_nombre_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key12 UNIQUE (nombre);


--
-- TOC entry 5513 (class 2606 OID 19703)
-- Name: regiones regiones_nombre_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key13 UNIQUE (nombre);


--
-- TOC entry 5515 (class 2606 OID 19705)
-- Name: regiones regiones_nombre_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key14 UNIQUE (nombre);


--
-- TOC entry 5517 (class 2606 OID 19707)
-- Name: regiones regiones_nombre_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key15 UNIQUE (nombre);


--
-- TOC entry 5519 (class 2606 OID 19709)
-- Name: regiones regiones_nombre_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key16 UNIQUE (nombre);


--
-- TOC entry 5521 (class 2606 OID 19711)
-- Name: regiones regiones_nombre_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key17 UNIQUE (nombre);


--
-- TOC entry 5523 (class 2606 OID 19713)
-- Name: regiones regiones_nombre_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key18 UNIQUE (nombre);


--
-- TOC entry 5525 (class 2606 OID 19715)
-- Name: regiones regiones_nombre_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key19 UNIQUE (nombre);


--
-- TOC entry 5527 (class 2606 OID 19717)
-- Name: regiones regiones_nombre_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key2 UNIQUE (nombre);


--
-- TOC entry 5529 (class 2606 OID 19719)
-- Name: regiones regiones_nombre_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key20 UNIQUE (nombre);


--
-- TOC entry 5531 (class 2606 OID 19721)
-- Name: regiones regiones_nombre_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key21 UNIQUE (nombre);


--
-- TOC entry 5533 (class 2606 OID 19723)
-- Name: regiones regiones_nombre_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key22 UNIQUE (nombre);


--
-- TOC entry 5535 (class 2606 OID 19725)
-- Name: regiones regiones_nombre_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key23 UNIQUE (nombre);


--
-- TOC entry 5537 (class 2606 OID 19727)
-- Name: regiones regiones_nombre_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key24 UNIQUE (nombre);


--
-- TOC entry 5539 (class 2606 OID 19729)
-- Name: regiones regiones_nombre_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key25 UNIQUE (nombre);


--
-- TOC entry 5541 (class 2606 OID 19731)
-- Name: regiones regiones_nombre_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key26 UNIQUE (nombre);


--
-- TOC entry 5543 (class 2606 OID 19733)
-- Name: regiones regiones_nombre_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key27 UNIQUE (nombre);


--
-- TOC entry 5545 (class 2606 OID 19735)
-- Name: regiones regiones_nombre_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key28 UNIQUE (nombre);


--
-- TOC entry 5547 (class 2606 OID 19737)
-- Name: regiones regiones_nombre_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key29 UNIQUE (nombre);


--
-- TOC entry 5549 (class 2606 OID 19739)
-- Name: regiones regiones_nombre_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key3 UNIQUE (nombre);


--
-- TOC entry 5551 (class 2606 OID 19741)
-- Name: regiones regiones_nombre_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key30 UNIQUE (nombre);


--
-- TOC entry 5553 (class 2606 OID 19743)
-- Name: regiones regiones_nombre_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key31 UNIQUE (nombre);


--
-- TOC entry 5555 (class 2606 OID 19745)
-- Name: regiones regiones_nombre_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key32 UNIQUE (nombre);


--
-- TOC entry 5557 (class 2606 OID 19747)
-- Name: regiones regiones_nombre_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key33 UNIQUE (nombre);


--
-- TOC entry 5559 (class 2606 OID 19749)
-- Name: regiones regiones_nombre_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key34 UNIQUE (nombre);


--
-- TOC entry 5561 (class 2606 OID 19751)
-- Name: regiones regiones_nombre_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key35 UNIQUE (nombre);


--
-- TOC entry 5563 (class 2606 OID 19753)
-- Name: regiones regiones_nombre_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key36 UNIQUE (nombre);


--
-- TOC entry 5565 (class 2606 OID 19755)
-- Name: regiones regiones_nombre_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key37 UNIQUE (nombre);


--
-- TOC entry 5567 (class 2606 OID 19757)
-- Name: regiones regiones_nombre_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key38 UNIQUE (nombre);


--
-- TOC entry 5569 (class 2606 OID 19759)
-- Name: regiones regiones_nombre_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key39 UNIQUE (nombre);


--
-- TOC entry 5571 (class 2606 OID 19761)
-- Name: regiones regiones_nombre_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key4 UNIQUE (nombre);


--
-- TOC entry 5573 (class 2606 OID 19763)
-- Name: regiones regiones_nombre_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key40 UNIQUE (nombre);


--
-- TOC entry 5575 (class 2606 OID 19765)
-- Name: regiones regiones_nombre_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key41 UNIQUE (nombre);


--
-- TOC entry 5577 (class 2606 OID 19767)
-- Name: regiones regiones_nombre_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key42 UNIQUE (nombre);


--
-- TOC entry 5579 (class 2606 OID 19769)
-- Name: regiones regiones_nombre_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key43 UNIQUE (nombre);


--
-- TOC entry 5581 (class 2606 OID 19771)
-- Name: regiones regiones_nombre_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key44 UNIQUE (nombre);


--
-- TOC entry 5583 (class 2606 OID 19773)
-- Name: regiones regiones_nombre_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key45 UNIQUE (nombre);


--
-- TOC entry 5585 (class 2606 OID 19775)
-- Name: regiones regiones_nombre_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key46 UNIQUE (nombre);


--
-- TOC entry 5587 (class 2606 OID 19777)
-- Name: regiones regiones_nombre_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key47 UNIQUE (nombre);


--
-- TOC entry 5589 (class 2606 OID 19779)
-- Name: regiones regiones_nombre_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key48 UNIQUE (nombre);


--
-- TOC entry 5591 (class 2606 OID 19781)
-- Name: regiones regiones_nombre_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key49 UNIQUE (nombre);


--
-- TOC entry 5593 (class 2606 OID 19783)
-- Name: regiones regiones_nombre_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key5 UNIQUE (nombre);


--
-- TOC entry 5595 (class 2606 OID 19785)
-- Name: regiones regiones_nombre_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key50 UNIQUE (nombre);


--
-- TOC entry 5597 (class 2606 OID 19787)
-- Name: regiones regiones_nombre_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key51 UNIQUE (nombre);


--
-- TOC entry 5599 (class 2606 OID 19789)
-- Name: regiones regiones_nombre_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key52 UNIQUE (nombre);


--
-- TOC entry 5601 (class 2606 OID 19791)
-- Name: regiones regiones_nombre_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key53 UNIQUE (nombre);


--
-- TOC entry 5603 (class 2606 OID 19793)
-- Name: regiones regiones_nombre_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key54 UNIQUE (nombre);


--
-- TOC entry 5605 (class 2606 OID 19795)
-- Name: regiones regiones_nombre_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key55 UNIQUE (nombre);


--
-- TOC entry 5607 (class 2606 OID 19797)
-- Name: regiones regiones_nombre_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key56 UNIQUE (nombre);


--
-- TOC entry 5609 (class 2606 OID 19799)
-- Name: regiones regiones_nombre_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key57 UNIQUE (nombre);


--
-- TOC entry 5611 (class 2606 OID 19801)
-- Name: regiones regiones_nombre_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key58 UNIQUE (nombre);


--
-- TOC entry 5613 (class 2606 OID 19803)
-- Name: regiones regiones_nombre_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key59 UNIQUE (nombre);


--
-- TOC entry 5615 (class 2606 OID 19805)
-- Name: regiones regiones_nombre_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key6 UNIQUE (nombre);


--
-- TOC entry 5617 (class 2606 OID 19807)
-- Name: regiones regiones_nombre_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key60 UNIQUE (nombre);


--
-- TOC entry 5619 (class 2606 OID 19809)
-- Name: regiones regiones_nombre_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key61 UNIQUE (nombre);


--
-- TOC entry 5621 (class 2606 OID 19811)
-- Name: regiones regiones_nombre_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key62 UNIQUE (nombre);


--
-- TOC entry 5623 (class 2606 OID 19813)
-- Name: regiones regiones_nombre_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key63 UNIQUE (nombre);


--
-- TOC entry 5625 (class 2606 OID 19815)
-- Name: regiones regiones_nombre_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key64 UNIQUE (nombre);


--
-- TOC entry 5627 (class 2606 OID 19817)
-- Name: regiones regiones_nombre_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key65 UNIQUE (nombre);


--
-- TOC entry 5629 (class 2606 OID 19819)
-- Name: regiones regiones_nombre_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key66 UNIQUE (nombre);


--
-- TOC entry 5631 (class 2606 OID 19821)
-- Name: regiones regiones_nombre_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key67 UNIQUE (nombre);


--
-- TOC entry 5633 (class 2606 OID 19823)
-- Name: regiones regiones_nombre_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key68 UNIQUE (nombre);


--
-- TOC entry 5635 (class 2606 OID 19825)
-- Name: regiones regiones_nombre_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key69 UNIQUE (nombre);


--
-- TOC entry 5637 (class 2606 OID 19827)
-- Name: regiones regiones_nombre_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key7 UNIQUE (nombre);


--
-- TOC entry 5639 (class 2606 OID 19829)
-- Name: regiones regiones_nombre_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key70 UNIQUE (nombre);


--
-- TOC entry 5641 (class 2606 OID 19831)
-- Name: regiones regiones_nombre_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key8 UNIQUE (nombre);


--
-- TOC entry 5643 (class 2606 OID 19833)
-- Name: regiones regiones_nombre_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_nombre_key9 UNIQUE (nombre);


--
-- TOC entry 5645 (class 2606 OID 19835)
-- Name: regiones regiones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_pkey PRIMARY KEY (id);


--
-- TOC entry 5647 (class 2606 OID 19837)
-- Name: tipo_vacantes tipo_vacante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_vacantes
    ADD CONSTRAINT tipo_vacante_pkey PRIMARY KEY (id);


--
-- TOC entry 5649 (class 2606 OID 19839)
-- Name: titulos_profesionales titulos_profesionales_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key UNIQUE (nombre);


--
-- TOC entry 5651 (class 2606 OID 19841)
-- Name: titulos_profesionales titulos_profesionales_nombre_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key1 UNIQUE (nombre);


--
-- TOC entry 5653 (class 2606 OID 19843)
-- Name: titulos_profesionales titulos_profesionales_nombre_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key10 UNIQUE (nombre);


--
-- TOC entry 5655 (class 2606 OID 19845)
-- Name: titulos_profesionales titulos_profesionales_nombre_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key11 UNIQUE (nombre);


--
-- TOC entry 5657 (class 2606 OID 19847)
-- Name: titulos_profesionales titulos_profesionales_nombre_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key12 UNIQUE (nombre);


--
-- TOC entry 5659 (class 2606 OID 19849)
-- Name: titulos_profesionales titulos_profesionales_nombre_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key13 UNIQUE (nombre);


--
-- TOC entry 5661 (class 2606 OID 19851)
-- Name: titulos_profesionales titulos_profesionales_nombre_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key14 UNIQUE (nombre);


--
-- TOC entry 5663 (class 2606 OID 19853)
-- Name: titulos_profesionales titulos_profesionales_nombre_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key15 UNIQUE (nombre);


--
-- TOC entry 5665 (class 2606 OID 19855)
-- Name: titulos_profesionales titulos_profesionales_nombre_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key16 UNIQUE (nombre);


--
-- TOC entry 5667 (class 2606 OID 19857)
-- Name: titulos_profesionales titulos_profesionales_nombre_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key17 UNIQUE (nombre);


--
-- TOC entry 5669 (class 2606 OID 19859)
-- Name: titulos_profesionales titulos_profesionales_nombre_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key18 UNIQUE (nombre);


--
-- TOC entry 5671 (class 2606 OID 19861)
-- Name: titulos_profesionales titulos_profesionales_nombre_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key19 UNIQUE (nombre);


--
-- TOC entry 5673 (class 2606 OID 19863)
-- Name: titulos_profesionales titulos_profesionales_nombre_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key2 UNIQUE (nombre);


--
-- TOC entry 5675 (class 2606 OID 19865)
-- Name: titulos_profesionales titulos_profesionales_nombre_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key20 UNIQUE (nombre);


--
-- TOC entry 5677 (class 2606 OID 19867)
-- Name: titulos_profesionales titulos_profesionales_nombre_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key21 UNIQUE (nombre);


--
-- TOC entry 5679 (class 2606 OID 19869)
-- Name: titulos_profesionales titulos_profesionales_nombre_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key22 UNIQUE (nombre);


--
-- TOC entry 5681 (class 2606 OID 19871)
-- Name: titulos_profesionales titulos_profesionales_nombre_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key23 UNIQUE (nombre);


--
-- TOC entry 5683 (class 2606 OID 19873)
-- Name: titulos_profesionales titulos_profesionales_nombre_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key24 UNIQUE (nombre);


--
-- TOC entry 5685 (class 2606 OID 19875)
-- Name: titulos_profesionales titulos_profesionales_nombre_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key25 UNIQUE (nombre);


--
-- TOC entry 5687 (class 2606 OID 19877)
-- Name: titulos_profesionales titulos_profesionales_nombre_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key26 UNIQUE (nombre);


--
-- TOC entry 5689 (class 2606 OID 19879)
-- Name: titulos_profesionales titulos_profesionales_nombre_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key27 UNIQUE (nombre);


--
-- TOC entry 5691 (class 2606 OID 19881)
-- Name: titulos_profesionales titulos_profesionales_nombre_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key28 UNIQUE (nombre);


--
-- TOC entry 5693 (class 2606 OID 19883)
-- Name: titulos_profesionales titulos_profesionales_nombre_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key29 UNIQUE (nombre);


--
-- TOC entry 5695 (class 2606 OID 19885)
-- Name: titulos_profesionales titulos_profesionales_nombre_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key3 UNIQUE (nombre);


--
-- TOC entry 5697 (class 2606 OID 19887)
-- Name: titulos_profesionales titulos_profesionales_nombre_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key30 UNIQUE (nombre);


--
-- TOC entry 5699 (class 2606 OID 19889)
-- Name: titulos_profesionales titulos_profesionales_nombre_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key31 UNIQUE (nombre);


--
-- TOC entry 5701 (class 2606 OID 19891)
-- Name: titulos_profesionales titulos_profesionales_nombre_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key32 UNIQUE (nombre);


--
-- TOC entry 5703 (class 2606 OID 19893)
-- Name: titulos_profesionales titulos_profesionales_nombre_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key33 UNIQUE (nombre);


--
-- TOC entry 5705 (class 2606 OID 19895)
-- Name: titulos_profesionales titulos_profesionales_nombre_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key34 UNIQUE (nombre);


--
-- TOC entry 5707 (class 2606 OID 19897)
-- Name: titulos_profesionales titulos_profesionales_nombre_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key35 UNIQUE (nombre);


--
-- TOC entry 5709 (class 2606 OID 19899)
-- Name: titulos_profesionales titulos_profesionales_nombre_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key36 UNIQUE (nombre);


--
-- TOC entry 5711 (class 2606 OID 19901)
-- Name: titulos_profesionales titulos_profesionales_nombre_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key37 UNIQUE (nombre);


--
-- TOC entry 5713 (class 2606 OID 19903)
-- Name: titulos_profesionales titulos_profesionales_nombre_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key38 UNIQUE (nombre);


--
-- TOC entry 5715 (class 2606 OID 19905)
-- Name: titulos_profesionales titulos_profesionales_nombre_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key39 UNIQUE (nombre);


--
-- TOC entry 5717 (class 2606 OID 19907)
-- Name: titulos_profesionales titulos_profesionales_nombre_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key4 UNIQUE (nombre);


--
-- TOC entry 5719 (class 2606 OID 19909)
-- Name: titulos_profesionales titulos_profesionales_nombre_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key40 UNIQUE (nombre);


--
-- TOC entry 5721 (class 2606 OID 19911)
-- Name: titulos_profesionales titulos_profesionales_nombre_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key41 UNIQUE (nombre);


--
-- TOC entry 5723 (class 2606 OID 19913)
-- Name: titulos_profesionales titulos_profesionales_nombre_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key42 UNIQUE (nombre);


--
-- TOC entry 5725 (class 2606 OID 19915)
-- Name: titulos_profesionales titulos_profesionales_nombre_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key43 UNIQUE (nombre);


--
-- TOC entry 5727 (class 2606 OID 19917)
-- Name: titulos_profesionales titulos_profesionales_nombre_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key44 UNIQUE (nombre);


--
-- TOC entry 5729 (class 2606 OID 19919)
-- Name: titulos_profesionales titulos_profesionales_nombre_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key45 UNIQUE (nombre);


--
-- TOC entry 5731 (class 2606 OID 19921)
-- Name: titulos_profesionales titulos_profesionales_nombre_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key46 UNIQUE (nombre);


--
-- TOC entry 5733 (class 2606 OID 19923)
-- Name: titulos_profesionales titulos_profesionales_nombre_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key47 UNIQUE (nombre);


--
-- TOC entry 5735 (class 2606 OID 19925)
-- Name: titulos_profesionales titulos_profesionales_nombre_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key48 UNIQUE (nombre);


--
-- TOC entry 5737 (class 2606 OID 19927)
-- Name: titulos_profesionales titulos_profesionales_nombre_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key49 UNIQUE (nombre);


--
-- TOC entry 5739 (class 2606 OID 19929)
-- Name: titulos_profesionales titulos_profesionales_nombre_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key5 UNIQUE (nombre);


--
-- TOC entry 5741 (class 2606 OID 19931)
-- Name: titulos_profesionales titulos_profesionales_nombre_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key50 UNIQUE (nombre);


--
-- TOC entry 5743 (class 2606 OID 19933)
-- Name: titulos_profesionales titulos_profesionales_nombre_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key51 UNIQUE (nombre);


--
-- TOC entry 5745 (class 2606 OID 19935)
-- Name: titulos_profesionales titulos_profesionales_nombre_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key52 UNIQUE (nombre);


--
-- TOC entry 5747 (class 2606 OID 19937)
-- Name: titulos_profesionales titulos_profesionales_nombre_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key53 UNIQUE (nombre);


--
-- TOC entry 5749 (class 2606 OID 19939)
-- Name: titulos_profesionales titulos_profesionales_nombre_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key54 UNIQUE (nombre);


--
-- TOC entry 5751 (class 2606 OID 19941)
-- Name: titulos_profesionales titulos_profesionales_nombre_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key55 UNIQUE (nombre);


--
-- TOC entry 5753 (class 2606 OID 19943)
-- Name: titulos_profesionales titulos_profesionales_nombre_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key56 UNIQUE (nombre);


--
-- TOC entry 5755 (class 2606 OID 19945)
-- Name: titulos_profesionales titulos_profesionales_nombre_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key57 UNIQUE (nombre);


--
-- TOC entry 5757 (class 2606 OID 19947)
-- Name: titulos_profesionales titulos_profesionales_nombre_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key58 UNIQUE (nombre);


--
-- TOC entry 5759 (class 2606 OID 19949)
-- Name: titulos_profesionales titulos_profesionales_nombre_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key59 UNIQUE (nombre);


--
-- TOC entry 5761 (class 2606 OID 19951)
-- Name: titulos_profesionales titulos_profesionales_nombre_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key6 UNIQUE (nombre);


--
-- TOC entry 5763 (class 2606 OID 19953)
-- Name: titulos_profesionales titulos_profesionales_nombre_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key60 UNIQUE (nombre);


--
-- TOC entry 5765 (class 2606 OID 19955)
-- Name: titulos_profesionales titulos_profesionales_nombre_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key61 UNIQUE (nombre);


--
-- TOC entry 5767 (class 2606 OID 19957)
-- Name: titulos_profesionales titulos_profesionales_nombre_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key62 UNIQUE (nombre);


--
-- TOC entry 5769 (class 2606 OID 19959)
-- Name: titulos_profesionales titulos_profesionales_nombre_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key63 UNIQUE (nombre);


--
-- TOC entry 5771 (class 2606 OID 19961)
-- Name: titulos_profesionales titulos_profesionales_nombre_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key64 UNIQUE (nombre);


--
-- TOC entry 5773 (class 2606 OID 19963)
-- Name: titulos_profesionales titulos_profesionales_nombre_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key65 UNIQUE (nombre);


--
-- TOC entry 5775 (class 2606 OID 19965)
-- Name: titulos_profesionales titulos_profesionales_nombre_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key66 UNIQUE (nombre);


--
-- TOC entry 5777 (class 2606 OID 19967)
-- Name: titulos_profesionales titulos_profesionales_nombre_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key67 UNIQUE (nombre);


--
-- TOC entry 5779 (class 2606 OID 19969)
-- Name: titulos_profesionales titulos_profesionales_nombre_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key68 UNIQUE (nombre);


--
-- TOC entry 5781 (class 2606 OID 19971)
-- Name: titulos_profesionales titulos_profesionales_nombre_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key69 UNIQUE (nombre);


--
-- TOC entry 5783 (class 2606 OID 19973)
-- Name: titulos_profesionales titulos_profesionales_nombre_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key7 UNIQUE (nombre);


--
-- TOC entry 5785 (class 2606 OID 19975)
-- Name: titulos_profesionales titulos_profesionales_nombre_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key70 UNIQUE (nombre);


--
-- TOC entry 5787 (class 2606 OID 19977)
-- Name: titulos_profesionales titulos_profesionales_nombre_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key8 UNIQUE (nombre);


--
-- TOC entry 5789 (class 2606 OID 19979)
-- Name: titulos_profesionales titulos_profesionales_nombre_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_nombre_key9 UNIQUE (nombre);


--
-- TOC entry 5791 (class 2606 OID 19981)
-- Name: titulos_profesionales titulos_profesionales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titulos_profesionales
    ADD CONSTRAINT titulos_profesionales_pkey PRIMARY KEY (id);


--
-- TOC entry 5793 (class 2606 OID 19983)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4934 (class 1259 OID 19984)
-- Name: idx_candidatos_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_candidatos_estado ON public.candidatos USING btree (estado_candidato_id);


--
-- TOC entry 4935 (class 1259 OID 19985)
-- Name: idx_candidatos_nombre; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_candidatos_nombre ON public.candidatos USING btree (nombre_completo);


--
-- TOC entry 4936 (class 1259 OID 19986)
-- Name: idx_candidatos_rut; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_candidatos_rut ON public.candidatos USING btree (rut);


--
-- TOC entry 4959 (class 1259 OID 19987)
-- Name: idx_comunas_region; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_comunas_region ON public.comunas USING btree (region_id);


--
-- TOC entry 5836 (class 2620 OID 19988)
-- Name: candidatos update_candidatos_modtime; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_candidatos_modtime BEFORE UPDATE ON public.candidatos FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- TOC entry 5837 (class 2620 OID 19989)
-- Name: comentarios update_comentarios_modtime; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_comentarios_modtime BEFORE UPDATE ON public.comentarios FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- TOC entry 5811 (class 2606 OID 20289)
-- Name: candidatos_modalidades CModalidades_candidato_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_modalidades
    ADD CONSTRAINT "CModalidades_candidato_id_fkey" FOREIGN KEY (candidato_id) REFERENCES public.candidatos(id) NOT VALID;


--
-- TOC entry 5812 (class 2606 OID 20294)
-- Name: candidatos_modalidades CModalidades_modalidad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_modalidades
    ADD CONSTRAINT "CModalidades_modalidad_id_fkey" FOREIGN KEY (modalidad_horaria_id) REFERENCES public.modalidades_horarias(id) NOT VALID;


--
-- TOC entry 5813 (class 2606 OID 19990)
-- Name: cargos Cargos_categoria_id_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT "Cargos_categoria_id_key" FOREIGN KEY (tipo_cargo_id) REFERENCES public.categoria_cargos(id) NOT VALID;


--
-- TOC entry 5806 (class 2606 OID 19995)
-- Name: candidatos_cargos candidatos_cargos_candidato_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_cargos
    ADD CONSTRAINT candidatos_cargos_candidato_id_fkey FOREIGN KEY (candidato_id) REFERENCES public.candidatos(id) ON DELETE CASCADE;


--
-- TOC entry 5807 (class 2606 OID 20000)
-- Name: candidatos_ciudades candidatos_ciudades_candidatos_id_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_ciudades
    ADD CONSTRAINT candidatos_ciudades_candidatos_id_key FOREIGN KEY (candidato_id) REFERENCES public.candidatos(id) NOT VALID;


--
-- TOC entry 5808 (class 2606 OID 20005)
-- Name: candidatos_ciudades candidatos_ciudades_ciudad_id_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_ciudades
    ADD CONSTRAINT candidatos_ciudades_ciudad_id_key FOREIGN KEY (ciudades_id) REFERENCES public.ciudades(id) NOT VALID;


--
-- TOC entry 5800 (class 2606 OID 20010)
-- Name: candidatos candidatos_comuna_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_comuna_id_fkey FOREIGN KEY (comuna_id) REFERENCES public.comunas(id) ON UPDATE CASCADE;


--
-- TOC entry 5801 (class 2606 OID 20015)
-- Name: candidatos candidatos_estado_candidato_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_estado_candidato_id_fkey FOREIGN KEY (estado_candidato_id) REFERENCES public.estado_candidatos(id) ON UPDATE CASCADE;


--
-- TOC entry 5802 (class 2606 OID 20020)
-- Name: candidatos candidatos_estado_civil_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_estado_civil_id_fkey FOREIGN KEY (estado_civil_id) REFERENCES public.estados_civiles(id) ON UPDATE CASCADE;


--
-- TOC entry 5809 (class 2606 OID 20207)
-- Name: candidatos_jornadas candidatos_jornadas_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_jornadas
    ADD CONSTRAINT candidatos_jornadas_id_fkey FOREIGN KEY (jornada_id) REFERENCES public.jornadas(id) NOT VALID;


--
-- TOC entry 5803 (class 2606 OID 20025)
-- Name: candidatos candidatos_nacionalidad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_nacionalidad_id_fkey FOREIGN KEY (nacionalidad_id) REFERENCES public.nacionalidades(id) ON UPDATE CASCADE;


--
-- TOC entry 5804 (class 2606 OID 20030)
-- Name: candidatos candidatos_titulo_profesional_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_titulo_profesional_id_fkey FOREIGN KEY (titulo_profesional_id) REFERENCES public.titulos_profesionales(id) ON UPDATE CASCADE;


--
-- TOC entry 5805 (class 2606 OID 20035)
-- Name: candidatos candidatos_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) NOT VALID;


--
-- TOC entry 5831 (class 2606 OID 20415)
-- Name: cartas_ofertas carta_oferta_candidato_i_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartas_ofertas
    ADD CONSTRAINT carta_oferta_candidato_i_fkey FOREIGN KEY (candidato_id) REFERENCES public.candidatos(id) NOT VALID;


--
-- TOC entry 5832 (class 2606 OID 20430)
-- Name: cartas_ofertas carta_oferta_cargo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartas_ofertas
    ADD CONSTRAINT carta_oferta_cargo_id_fkey FOREIGN KEY (cargo_id) REFERENCES public.cargos(id) NOT VALID;


--
-- TOC entry 5833 (class 2606 OID 20410)
-- Name: cartas_ofertas carta_oferta_convocatoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartas_ofertas
    ADD CONSTRAINT carta_oferta_convocatoria_id_fkey FOREIGN KEY (convocatoria_id) REFERENCES public.convocatorias(id) NOT VALID;


--
-- TOC entry 5834 (class 2606 OID 20420)
-- Name: cartas_ofertas carta_oferta_institucion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartas_ofertas
    ADD CONSTRAINT carta_oferta_institucion_id_fkey FOREIGN KEY (institucion_id) REFERENCES public.instituciones(id) NOT VALID;


--
-- TOC entry 5835 (class 2606 OID 20425)
-- Name: cartas_ofertas carta_oferta_jornada_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartas_ofertas
    ADD CONSTRAINT carta_oferta_jornada_id_fkey FOREIGN KEY (jornada_id) REFERENCES public.jornadas(id) NOT VALID;


--
-- TOC entry 5814 (class 2606 OID 20040)
-- Name: comentarios comentarios_candidato_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT comentarios_candidato_id_fkey FOREIGN KEY (candidato_id) REFERENCES public.candidatos(id) ON UPDATE CASCADE;


--
-- TOC entry 5815 (class 2606 OID 20045)
-- Name: comentarios comentarios_creador_id_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT comentarios_creador_id_key FOREIGN KEY (creador_id) REFERENCES public.candidatos(id) NOT VALID;


--
-- TOC entry 5816 (class 2606 OID 20050)
-- Name: comunas comunas_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comunas
    ADD CONSTRAINT comunas_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regiones(id) ON UPDATE CASCADE;


--
-- TOC entry 5817 (class 2606 OID 20055)
-- Name: convocatorias convocatoria_ciudades_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatoria_ciudades_id_fkey FOREIGN KEY (ciudad_id) REFERENCES public.ciudades(id) NOT VALID;


--
-- TOC entry 5818 (class 2606 OID 20060)
-- Name: convocatorias convocatoria_jornada_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatoria_jornada_id_fkey FOREIGN KEY (jornada_id) REFERENCES public.jornadas(id) NOT VALID;


--
-- TOC entry 5819 (class 2606 OID 20065)
-- Name: convocatorias convocatoria_modalidad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatoria_modalidad_id_fkey FOREIGN KEY (modalidad_id) REFERENCES public.modalidades_horarias(id) NOT VALID;


--
-- TOC entry 5820 (class 2606 OID 20070)
-- Name: convocatorias convocatoria_tipo_vacante_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatoria_tipo_vacante_id_fkey FOREIGN KEY (categoria_cargo_id) REFERENCES public.categoria_cargos(id) NOT VALID;


--
-- TOC entry 5821 (class 2606 OID 20075)
-- Name: convocatorias convocatorias_cargos_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_cargos_id_fkey FOREIGN KEY (cargo_id) REFERENCES public.cargos(id) NOT VALID;


--
-- TOC entry 5822 (class 2606 OID 20080)
-- Name: convocatorias convocatorias_categoria_cargo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_categoria_cargo_id_fkey FOREIGN KEY (categoria_cargo_id) REFERENCES public.categoria_cargos(id) NOT VALID;


--
-- TOC entry 5823 (class 2606 OID 20085)
-- Name: convocatorias convocatorias_estado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_estado_id_fkey FOREIGN KEY (estado_id) REFERENCES public.estado_convocatoria(id) NOT VALID;


--
-- TOC entry 5824 (class 2606 OID 20090)
-- Name: convocatorias convocatorias_institucion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_institucion_id_fkey FOREIGN KEY (institucion_id) REFERENCES public.instituciones(id) NOT VALID;


--
-- TOC entry 5825 (class 2606 OID 20095)
-- Name: documentos_candidatos documentos_candidatos_candidato_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_candidatos
    ADD CONSTRAINT documentos_candidatos_candidato_id_fkey FOREIGN KEY (candidato_id) REFERENCES public.candidatos(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5826 (class 2606 OID 20100)
-- Name: documentos_candidatos documentos_candidatos_documento_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentos_candidatos
    ADD CONSTRAINT documentos_candidatos_documento_id_fkey FOREIGN KEY (documento_id) REFERENCES public.documentos(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5827 (class 2606 OID 20131)
-- Name: instituciones instituciones_ciudad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instituciones
    ADD CONSTRAINT instituciones_ciudad_id_fkey FOREIGN KEY (ciudad_id) REFERENCES public.ciudades(id) NOT VALID;


--
-- TOC entry 5828 (class 2606 OID 20136)
-- Name: instituciones instituciones_director_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instituciones
    ADD CONSTRAINT instituciones_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.directores(id) NOT VALID;


--
-- TOC entry 5810 (class 2606 OID 20212)
-- Name: candidatos_jornadas jornadas_candidatos_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidatos_jornadas
    ADD CONSTRAINT jornadas_candidatos_id_fkey FOREIGN KEY (candidato_id) REFERENCES public.candidatos(id) NOT VALID;


--
-- TOC entry 5829 (class 2606 OID 20105)
-- Name: postulaciones postulaciones_candidato_id_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postulaciones
    ADD CONSTRAINT postulaciones_candidato_id_key FOREIGN KEY (candidato_id) REFERENCES public.candidatos(id) NOT VALID;


--
-- TOC entry 5830 (class 2606 OID 20110)
-- Name: postulaciones postulaciones_convocatoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postulaciones
    ADD CONSTRAINT postulaciones_convocatoria_id_fkey FOREIGN KEY (convocatoria_id) REFERENCES public.convocatorias(id) NOT VALID;


--
-- TOC entry 6048 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-10-24 16:36:39

--
-- PostgreSQL database dump complete
--

\unrestrict nfcVr2Fph3oe4bfCw6Fjfc4lO2m7QFjSMCSxZ3HMtCVmXthA07juohMkK8RGJrZ

