-- Adminer 4.6.2 PostgreSQL dump

DROP TABLE IF EXISTS "gds";
CREATE TABLE "public"."gds" (
    "id" real,
    "gds" text,
    "title" text,
    "description" text,
    "type" text,
    "pubmed_id" text,
    "gpl" text,
    "platform_organism" text,
    "platform_technology_type" text,
    "feature_count" bigint,
    "sample_organism" text,
    "sample_type" text,
    "channel_count" text,
    "sample_count" bigint,
    "value_type" text,
    "gse" text,
    "order" text,
    "update_date" text
) WITH (oids = false);

CREATE INDEX "idx_454168_gds_acc_idx" ON "public"."gds" USING btree ("gds");


DROP TABLE IF EXISTS "gds_subset";
CREATE TABLE "public"."gds_subset" (
    "id" real,
    "name" text,
    "gds" text,
    "description" text,
    "sample_id" text,
    "type" text
) WITH (oids = false);


DROP TABLE IF EXISTS "geoconvert";
CREATE TABLE "public"."geoconvert" (
    "from_acc" text,
    "to_acc" text,
    "to_type" text
) WITH (oids = false);


DROP TABLE IF EXISTS "geodb_column_desc";
CREATE TABLE "public"."geodb_column_desc" (
    "tablename" text,
    "fieldname" text,
    "description" text
) WITH (oids = false);


DROP TABLE IF EXISTS "gpl";
CREATE TABLE "public"."gpl" (
    "id" real,
    "title" text,
    "gpl" text,
    "status" text,
    "submission_date" text,
    "last_update_date" text,
    "technology" text,
    "distribution" text,
    "organism" text,
    "manufacturer" text,
    "manufacture_protocol" text,
    "coating" text,
    "catalog_number" text,
    "support" text,
    "description" text,
    "web_link" text,
    "contact" text,
    "data_row_count" real,
    "supplementary_file" text,
    "bioc_package" text
) WITH (oids = false);

CREATE INDEX "idx_454144_gpl_acc_idx" ON "public"."gpl" USING btree ("gpl");


DROP TABLE IF EXISTS "gse";
CREATE TABLE "public"."gse" (
    "id" real,
    "title" text,
    "gse" text,
    "status" text,
    "submission_date" text,
    "last_update_date" text,
    "pubmed_id" bigint,
    "summary" text,
    "type" text,
    "contributor" text,
    "web_link" text,
    "overall_design" text,
    "repeats" text,
    "repeats_sample_list" text,
    "variable" text,
    "variable_description" text,
    "contact" text,
    "supplementary_file" text
) WITH (oids = false);

CREATE INDEX "idx_454138_gse_acc_idx" ON "public"."gse" USING btree ("gse");


DROP TABLE IF EXISTS "gse_gpl";
CREATE TABLE "public"."gse_gpl" (
    "gse" text,
    "gpl" text
) WITH (oids = false);


DROP TABLE IF EXISTS "gse_gsm";
CREATE TABLE "public"."gse_gsm" (
    "gse" text,
    "gsm" text
) WITH (oids = false);

CREATE INDEX "idx_454156_gse_gsm_idx1" ON "public"."gse_gsm" USING btree ("gse");

CREATE INDEX "idx_454156_gse_gsm_idx2" ON "public"."gse_gsm" USING btree ("gsm");


DROP TABLE IF EXISTS "gsm";
CREATE TABLE "public"."gsm" (
    "id" real,
    "title" text,
    "gsm" text,
    "series_id" text,
    "gpl" text,
    "status" text,
    "submission_date" text,
    "last_update_date" text,
    "type" text,
    "source_name_ch1" text,
    "organism_ch1" text,
    "characteristics_ch1" text,
    "molecule_ch1" text,
    "label_ch1" text,
    "treatment_protocol_ch1" text,
    "extract_protocol_ch1" text,
    "label_protocol_ch1" text,
    "source_name_ch2" text,
    "organism_ch2" text,
    "characteristics_ch2" text,
    "molecule_ch2" text,
    "label_ch2" text,
    "treatment_protocol_ch2" text,
    "extract_protocol_ch2" text,
    "label_protocol_ch2" text,
    "hyb_protocol" text,
    "description" text,
    "data_processing" text,
    "contact" text,
    "supplementary_file" text,
    "data_row_count" real,
    "channel_count" real
) WITH (oids = false);


DROP TABLE IF EXISTS "metainfo";
CREATE TABLE "public"."metainfo" (
    "name" text,
    "value" text
) WITH (oids = false);


DROP TABLE IF EXISTS "smatrix";
CREATE TABLE "public"."smatrix" (
    "id" bigint,
    "smatrix" text,
    "gse" text,
    "gpl" text,
    "gsm_count" bigint,
    "last_update_date" text
) WITH (oids = false);

CREATE INDEX "idx_454180_smatrix_gpl_idx" ON "public"."smatrix" USING btree ("gpl");

CREATE INDEX "idx_454180_smatrix_gse_idx" ON "public"."smatrix" USING btree ("gse");

CREATE INDEX "idx_454180_smatrix_last_update_date_idx" ON "public"."smatrix" USING btree ("last_update_date");

CREATE INDEX "idx_454180_smatrix_name_idx" ON "public"."smatrix" USING btree ("smatrix");


-- 2018-06-16 15:51:50.98873+00
