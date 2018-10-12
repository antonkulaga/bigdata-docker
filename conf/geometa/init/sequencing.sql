/* Tables for sequencing */

/* Molecules table*/

DROP TABLE IF EXISTS "molecules";
DROP SEQUENCE IF EXISTS molecules_id_seq;
CREATE SEQUENCE molecules_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."molecules" (
    "id" integer DEFAULT nextval('molecules_id_seq') NOT NULL,
    "molecule" text NOT NULL
) WITH (oids = false);

/* Organisms table*/

DROP TABLE IF EXISTS "organisms";
DROP SEQUENCE IF EXISTS organisms_id_seq;
CREATE SEQUENCE organisms_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."organisms" (
    "id" integer DEFAULT nextval('organisms_id_seq') NOT NULL,
    "name" text NOT NULL
) WITH (oids = false);

/* Samples table*/


DROP TABLE IF EXISTS "samples";
DROP SEQUENCE IF EXISTS samples_id_seq;
CREATE SEQUENCE samples_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."samples" (
    "id"  integer DEFAULT nextval('samples_id_seq') NOT NULL,
    "title" text NOT NULL,
    "gsm" text NOT NULL,
    "gse" text NOT NULL,
    "gpl" text NOT NULL,
    "sequencer_id" integer NOT NULL,
    "molecule_id" integer NOT NULL,
    "organism_id" integer NOT NULL,
    "characteristics" text NOT NULL,
    "status" text NOT NULL,
    "submission_date" text NOT NULL,
    "last_update_date" text NOT NULL,
    "type" text NOT NULL,
    "source_name" text NOT NULL,
    "treatment_protocol" text NOT NULL,
    "extract_protocol" text NOT NULL,
    "description" text NOT NULL,
    "data_processing" text NOT NULL,
    "contact" text NOT NULL,
    CONSTRAINT "samples_ID" PRIMARY KEY ("id")
) WITH (oids = false);

/* Sequencers table */

DROP TABLE IF EXISTS "sequencers";
DROP SEQUENCE IF EXISTS sequencers_id_seq;
CREATE SEQUENCE sequencers_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;
CREATE TABLE "public"."sequencers" (
    "id" integer DEFAULT nextval('sequencers_id_seq') NOT NULL,
    "model" text NOT NULL
) WITH (oids = false);