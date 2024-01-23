/*
 Navicat Premium Data Transfer

 Source Server         : PSQL
 Source Server Type    : PostgreSQL
 Source Server Version : 120017 (120017)
 Source Host           : 113.31.110.212:5432
 Source Catalog        : al
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 120017 (120017)
 File Encoding         : 65001

 Date: 22/01/2024 20:59:15
*/


-- ----------------------------
-- Table structure for chart
-- ----------------------------
DROP TABLE IF EXISTS "public"."chart";
CREATE TABLE "public"."chart" (
  "chartid" int4 NOT NULL DEFAULT nextval('chart_chartid_seq'::regclass),
  "config" json,
  "dataset" json,
  "mapping" json
)
;

-- ----------------------------
-- Records of chart
-- ----------------------------
INSERT INTO "public"."chart" VALUES (57, '{"type": "TSL", "input": 10, "name": "single-detect-12/6"}', '{"datasetid": 165, "dataset_name": "S4-ADL2.test.csv@79.csv", "example_row": {"date": 1, "channel_1": -47, "label": 0}, "task_type": null, "task_id": null}', '{"date": ["date"], "X": ["channel_1", "label"], "X_predict": ["channel_1", "label"], "z": 10}');
INSERT INTO "public"."chart" VALUES (58, '{"type": "TSL", "input": 10, "name": "single-forecast-12/6"}', '{"datasetid": 119, "dataset_name": "m4_yearly_dataset_10842.csv", "example_row": {"date": "1971-06-30 12:00:00", "channel_1": 3321.5}, "task_type": null, "task_id": null}', '{"date": ["date"], "X": ["channel_1"], "X_predict": ["channel_1"], "z": 10}');
INSERT INTO "public"."chart" VALUES (61, '{"type": "TSL", "input": 10, "name": "UCR-12/6"}', '{"datasetid": 144, "dataset_name": "004_UCR_Anomaly_DISTORTEDBIDMC1_2500_5400_5600.csv", "example_row": {"date": 1, "channel_1": -2785.9403, "label": 0}, "task_type": null, "task_id": null}', '{"date": ["date"], "X": ["channel_1", "label"], "X_predict": ["channel_1", "label"], "z": 10}');
INSERT INTO "public"."chart" VALUES (62, '{"type": "TSL", "input": 10, "name": "etth-12/6"}', '{"datasetid": 120, "dataset_name": "ETTh2.csv", "example_row": {"date": "2016-07-01 00:00:00", "HUFL": 41.13000106811523, "HULL": 12.480999946594238, "MUFL": 36.5359992980957, "MULL": 9.354999542236328, "LUFL": 4.423999786376953, "LULL": 1.3109999895095823, "OT": 38.6619987487793}, "task_type": null, "task_id": null}', '{"date": ["date"], "X": ["HUFL", "HULL", "MUFL", "MULL", "LUFL", "LULL", "OT"], "X_predict": ["HUFL", "HULL", "MUFL", "MULL", "LUFL", "LULL", "OT"], "z": 10}');
INSERT INTO "public"."chart" VALUES (63, '{"type": "TSL", "input": 10, "name": "single-label-detect-with-res-12/6"}', '{"datasetid": 165, "dataset_name": "S4-ADL2.test.csv@79.csv", "example_row": {"date": 1, "channel_1": -47, "label": 0}, "task_type": "label_detect", "task_id": 22}', '{"date": ["date"], "X": ["channel_1", "label"], "X_predict": ["channel_1", "label"], "z": 10}');
INSERT INTO "public"."chart" VALUES (64, '{"type": "TSL", "input": 10, "name": "single-forecast-with-res-12/6"}', '{"datasetid": 119, "dataset_name": "m4_yearly_dataset_10842.csv", "example_row": {"date": "1971-06-30 12:00:00", "channel_1": 3321.5}, "task_type": "forecast", "task_id": 23}', '{"date": ["date"], "X": ["channel_1"], "X_predict": ["channel_1"], "z": 10}');
INSERT INTO "public"."chart" VALUES (66, '{"type": "TSL", "name": "111"}', '{"datasetid": 3, "config": {"host": "113.31.110.212", "port": "5432", "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al", "query": "\n\n\n\n\n\n\n\n\n\n\nselect * from datasource;\n\n\n"}, "dataset_name": "dataset1", "query": "\n\n\n\n\n\n\n\n\n\n\nselect * from datasource;\n\n\n", "example_row": {"datasourceid": 1, "config": {"host": "113.31.110.212", "port": 5432, "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al"}}}', '{"date": [], "X": []}');

-- ----------------------------
-- Primary Key structure for table chart
-- ----------------------------
ALTER TABLE "public"."chart" ADD CONSTRAINT "chart_pkey" PRIMARY KEY ("chartid");
