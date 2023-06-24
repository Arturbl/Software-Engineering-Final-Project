-- Table: public.User

CREATE SCHEMA IF NOT EXISTS "arduino-security-system-postgres-db";

DROP TABLE IF EXISTS "arduino-security-system-postgres-db"."User";

CREATE TABLE IF NOT EXISTS "arduino-security-system-postgres-db"."User"
(
    userid   bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    nif      character varying(9) COLLATE pg_catalog."default",
    morada   character varying(50) COLLATE pg_catalog."default",
    admin    boolean,
    username character varying(20) COLLATE pg_catalog."default",
    password character varying(300) COLLATE pg_catalog."default",
    active   boolean DEFAULT true,
    CONSTRAINT pk_user PRIMARY KEY (userid)
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS "User"
    OWNER to postgres;
-- Table: public.registro_alarme

DROP TABLE IF EXISTS "arduino-security-system-postgres-db".registro_alarme;

CREATE TABLE IF NOT EXISTS "arduino-security-system-postgres-db".registro_alarme
(
    distancia  numeric(10, 3),
    registroid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    data       date DEFAULT CURRENT_TIMESTAMP,
    userid     bigint,
    CONSTRAINT pk_registro PRIMARY KEY (registroid),
    CONSTRAINT fk_tabela_filho_tabela_pai FOREIGN KEY (userid)
        REFERENCES "arduino-security-system-postgres-db"."User" (userid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS registro_alarme
    OWNER to postgres;

COMMENT ON COLUMN "arduino-security-system-postgres-db".registro_alarme.userid
    IS 'User que desativou o alarme';


DROP TABLE IF EXISTS "arduino-security-system-postgres-db"."user_session";

CREATE TABLE IF NOT EXISTS "arduino-security-system-postgres-db"."user_session"
(
    id           bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    userid       bigint,
    token        character varying(50) COLLATE pg_catalog."default",
    date_add     date DEFAULT CURRENT_TIMESTAMP,
    date_expires date,
    CONSTRAINT id PRIMARY KEY (id),
    CONSTRAINT fk_tabela_filho_tabela_pai FOREIGN KEY (userid)
        REFERENCES "arduino-security-system-postgres-db"."User" (userid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS "user_session"
    OWNER to postgres;