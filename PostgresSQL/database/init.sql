-- Table: public.User

CREATE SCHEMA IF NOT EXISTS "arduino-security-system-postgres-db";

DROP TABLE IF EXISTS "arduino-security-system-postgres-db"."User";

CREATE TABLE IF NOT EXISTS "arduino-security-system-postgres-db"."User"
(
    userid   bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    nif      character varying(9) COLLATE pg_catalog."default",
    morada   character varying(50) COLLATE pg_catalog."default",
    admin    boolean,
    username character varying(20) COLLATE pg_catalog."default" UNIQUE,
    password character varying(300) COLLATE pg_catalog."default",
    active   boolean DEFAULT true,
    CONSTRAINT pk_user PRIMARY KEY (userid)
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS "User"
    OWNER to postgres;

DO
$$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM "arduino-security-system-postgres-db"."User" WHERE username = 'admin') THEN
            -- Criar o usuário "admin" com senha criptografada e propriedade "admin" como true
            INSERT INTO "arduino-security-system-postgres-db"."User" (nif, morada, admin, username, password)
            VALUES (241144949, NULL, true, 'admin',
                    '$6$rounds=1000$ueCGNzfSS9DT$QZutO3yqivh6uJ.PLN2TtBaL/piLVbJOTe5ghh.47U3b5iGeVEUeClaWEFx5yExNIWUqX/m..gt290xD8KLfK/');
        END IF;
    END
$$;


-- Table: public.registro_alarme

DROP TABLE IF EXISTS "arduino-security-system-postgres-db".registro_alarme;

CREATE TABLE IF NOT EXISTS "arduino-security-system-postgres-db".registro_alarme
(
    distancia     numeric(10, 3),
    registroid    bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    register_data date DEFAULT CURRENT_TIMESTAMP,
    turn_off_data date,
    userid        bigint,
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


DROP TABLE IF EXISTS "arduino-security-system-postgres-db".alarm_status;

CREATE TABLE IF NOT EXISTS "arduino-security-system-postgres-db".alarm_status
(
    status_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    active    boolean,
    userid    bigint,
    data      date DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_registro PRIMARY KEY (status_id),
    CONSTRAINT fk_tabela_filho_tabela_pai FOREIGN KEY (userid)
        REFERENCES "arduino-security-system-postgres-db"."User" (userid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS alarm_status
    OWNER to postgres;


DROP TABLE IF EXISTS "arduino-security-system-postgres-db"."user_session";

CREATE TABLE IF NOT EXISTS "arduino-security-system-postgres-db"."user_session"
(
    id           bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    userid       bigint,
    token        character varying(50) COLLATE pg_catalog."default",
    date_add     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_expires TIMESTAMP,
    CONSTRAINT id PRIMARY KEY (id),
    CONSTRAINT fk_tabela_filho_tabela_pai FOREIGN KEY (userid)
        REFERENCES "arduino-security-system-postgres-db"."User" (userid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS "user_session"
    OWNER to postgres;