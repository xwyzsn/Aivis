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

 Date: 22/01/2024 20:59:30
*/


-- ----------------------------
-- Table structure for dataset
-- ----------------------------
DROP TABLE IF EXISTS "public"."dataset";
CREATE TABLE "public"."dataset" (
  "datasetid" int4 NOT NULL DEFAULT nextval('dataset_datasetid_seq'::regclass),
  "query" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "example_row" json NOT NULL,
  "config" json,
  "dataset_name" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of dataset
-- ----------------------------
INSERT INTO "public"."dataset" VALUES (3, '










select * from datasource;


', '{"datasourceid": 1, "config": {"host": "113.31.110.212", "port": 5432, "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al"}}', '{"host": "113.31.110.212", "port": "5432", "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al", "query": "\n\n\n\n\n\n\n\n\n\n\nselect * from datasource;\n\n\n"}', 'dataset1');
INSERT INTO "public"."dataset" VALUES (4, '










select * from datasource;


', '{"datasourceid": 1, "config": {"host": "113.31.110.212", "port": 5432, "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al"}}', '{"host": "113.31.110.212", "port": "5432", "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al", "query": "\n\n\n\n\n\n\n\n\n\n\nselect * from datasource;\n\n\n"}', 'dataset2');
INSERT INTO "public"."dataset" VALUES (5, '










select * from datasource;


', '{"datasourceid": 1, "config": {"host": "113.31.110.212", "port": 5432, "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al"}}', '{"host": "113.31.110.212", "port": "5432", "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al", "query": "\n\n\n\n\n\n\n\n\n\n\nselect * from datasource;\n\n\n"}', 'dataset3');
INSERT INTO "public"."dataset" VALUES (6, '



select * from test;









', '{"time": "2018-11-14", "y": 8.4, "y_pred": "4.06"}', '{"host": "113.31.110.212", "port": "5432", "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al", "query": "\n\n\n\nselect * from test;\n\n\n\n\n\n\n\n\n\n"}', 'test_dataset');
INSERT INTO "public"."dataset" VALUES (7, '



select * from test limit 10;









', '{"time": "2018-11-14", "y": 8.4, "y_pred": "4.06"}', '{"host": "113.31.110.212", "port": "5432", "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al", "query": "\n\n\n\nselect * from test limit 10;\n\n\n\n\n\n\n\n\n\n"}', 'test_dataset2');
INSERT INTO "public"."dataset" VALUES (8, '

select * from test limit 20 ;











', '{"time": "2018-11-14", "y": 8.4, "y_pred": "4.06"}', '{"host": "113.31.110.212", "port": "5432", "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al", "query": "\n\nselect * from test limit 20 ;\n\n\n\n\n\n\n\n\n\n\n\n"}', 'test_dataset3');
INSERT INTO "public"."dataset" VALUES (9, '
select * from test;












', '{"time": "2018-11-14", "y": 8.4, "y_pred": "4.06"}', '{"host": "113.31.110.212", "port": "5432", "user": "zzh", "password": "zzh0117.", "type": "psql", "database": "al", "query": "\nselect * from test;\n\n\n\n\n\n\n\n\n\n\n\n\n"}', '');
INSERT INTO "public"."dataset" VALUES (10, 'select * from ETTh1 limit 10;













', '{"date": "2016-07-01 00:00:00", "HUFL": "5.827000141143799", "HULL": "2.009000062942505", "MUFL": "1.5989999771118164", "MULL": "0.4620000123977661", "LUFL": "4.203000068664552", "LULL": "1.3400000333786009", "OT": "30.5310001373291"}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "type": "mysql", "database": "db11", "query": "select * from ETTh1 limit 10;\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}', 'ETTH1');
INSERT INTO "public"."dataset" VALUES (17, 'select * from ETTh1 limit 10', '{"date": "2016-07-01 00:00:00", "HUFL": "5.827000141143799", "HULL": "2.009000062942505", "MUFL": "1.5989999771118164", "MULL": "0.4620000123977661", "LUFL": "4.203000068664552", "LULL": "1.3400000333786009", "OT": "30.5310001373291"}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "type": "mysql", "database": "db11", "query": "select * from ETTh1 limit 10"}', '');
INSERT INTO "public"."dataset" VALUES (18, 'select * from  ETTh1 limit 10', '{"date": "2016-07-01 00:00:00", "HUFL": "5.827000141143799", "HULL": "2.009000062942505", "MUFL": "1.5989999771118164", "MULL": "0.4620000123977661", "LUFL": "4.203000068664552", "LULL": "1.3400000333786009", "OT": "30.5310001373291"}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "type": "mysql", "database": "db11", "query": "select * from  ETTh1 limit 10"}', '');
INSERT INTO "public"."dataset" VALUES (19, 'select * from  ETTh1 limit 10', '{"date": "2016-07-01 00:00:00", "HUFL": "5.827000141143799", "HULL": "2.009000062942505", "MUFL": "1.5989999771118164", "MULL": "0.4620000123977661", "LUFL": "4.203000068664552", "LULL": "1.3400000333786009", "OT": "30.5310001373291"}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "type": "mysql", "database": "db11", "query": "select * from  ETTh1 limit 10"}', '');
INSERT INTO "public"."dataset" VALUES (20, 'select * from ETTh1 limit 10;', '{"date": "2016-07-01 00:00:00", "HUFL": "5.827000141143799", "HULL": "2.009000062942505", "MUFL": "1.5989999771118164", "MULL": "0.4620000123977661", "LUFL": "4.203000068664552", "LULL": "1.3400000333786009", "OT": "30.5310001373291"}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "type": "mysql", "database": "db11", "query": "select * from ETTh1 limit 10;"}', '1111');
INSERT INTO "public"."dataset" VALUES (21, 'select * from 000d88f721ba4c2fa723a55d52999475', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "000d88f721ba4c2fa723a55d52999475", "dataset_name": "000d88f721ba4c2fa723a55d52999475", "query": "select * from 000d88f721ba4c2fa723a55d52999475 limit 10;"}', 'triformer_10_output2023-09-27 15:15:04');
INSERT INTO "public"."dataset" VALUES (22, 'select * from 5330473cb6a340e8ad02c24902aa9946', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "5330473cb6a340e8ad02c24902aa9946", "dataset_name": "5330473cb6a340e8ad02c24902aa9946", "query": "select * from 5330473cb6a340e8ad02c24902aa9946 limit 10;"}', 'triformer_10_output2023-09-27 15:36:10');
INSERT INTO "public"."dataset" VALUES (23, 'select * from f29033be9568423bb09d7778dcde89b9', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "f29033be9568423bb09d7778dcde89b9", "dataset_name": "f29033be9568423bb09d7778dcde89b9", "query": "select * from f29033be9568423bb09d7778dcde89b9 limit 10;"}', 'triformer_10_output2023-09-27 15:37:07');
INSERT INTO "public"."dataset" VALUES (13, 'select * from 01db8d875dbf438f899b515994b1b427', '{"date": "2018-11-14", "y": 8.4, "y_pred": "4.06"}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "01db8d875dbf438f899b515994b1b427", "query": "select * from 01db8d875dbf438f899b515994b1b427 limit 10;"}', 'triformer_10_output');
INSERT INTO "public"."dataset" VALUES (14, 'select * from 381a31e42dfd42e2955952115990ea58', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "381a31e42dfd42e2955952115990ea58", "query": "select * from 381a31e42dfd42e2955952115990ea58 limit 10;"}', 'triformer_10_output');
INSERT INTO "public"."dataset" VALUES (15, '
select * from LPC_dataset;












', '{"date": "2023-07-04T20:17:25", "real_data": 1.1, "predict_data": null}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "type": "mysql", "database": "db11", "query": "\nselect * from LPC_dataset;\n\n\n\n\n\n\n\n\n\n\n\n\n"}', '');
INSERT INTO "public"."dataset" VALUES (16, 'select * from 30a397030bfd4e84bd9010b27b49029c', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "30a397030bfd4e84bd9010b27b49029c", "dataset_name": "30a397030bfd4e84bd9010b27b49029c", "query": "select * from 30a397030bfd4e84bd9010b27b49029c limit 10;"}', 'triformer_10_output2023-07-05 09:45:07');
INSERT INTO "public"."dataset" VALUES (24, 'select * from fd9cfe9c2e35471685da9c2af9ccb830', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "fd9cfe9c2e35471685da9c2af9ccb830", "dataset_name": "fd9cfe9c2e35471685da9c2af9ccb830", "query": "select * from fd9cfe9c2e35471685da9c2af9ccb830 limit 10;"}', 'triformer_10_output2023-09-27 15:52:12');
INSERT INTO "public"."dataset" VALUES (25, 'select * from 297fcd99533e4b5fa2095b7f87e36a44', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "297fcd99533e4b5fa2095b7f87e36a44", "dataset_name": "297fcd99533e4b5fa2095b7f87e36a44", "query": "select * from 297fcd99533e4b5fa2095b7f87e36a44 limit 10;"}', 'triformer_10_output2023-09-27 15:53:33');
INSERT INTO "public"."dataset" VALUES (26, 'select * from bc1c13ca7da24ee0821e6218b764aa19', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "bc1c13ca7da24ee0821e6218b764aa19", "dataset_name": "bc1c13ca7da24ee0821e6218b764aa19", "query": "select * from bc1c13ca7da24ee0821e6218b764aa19 limit 10;"}', 'triformer_10_output2023-09-27 16:00:08');
INSERT INTO "public"."dataset" VALUES (27, 'select * from 46c00a8bb32341e48cc02fc8d3a6cc3b', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "46c00a8bb32341e48cc02fc8d3a6cc3b", "dataset_name": "46c00a8bb32341e48cc02fc8d3a6cc3b", "query": "select * from 46c00a8bb32341e48cc02fc8d3a6cc3b limit 10;"}', 'triformer_10_output2023-09-27 16:07:27');
INSERT INTO "public"."dataset" VALUES (28, 'select * from c969b9932d6f44328de9cde21c7bd506', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "c969b9932d6f44328de9cde21c7bd506", "dataset_name": "c969b9932d6f44328de9cde21c7bd506", "query": "select * from c969b9932d6f44328de9cde21c7bd506 limit 10;"}', 'triformer_10_output2023-09-27 16:08:38');
INSERT INTO "public"."dataset" VALUES (29, 'select * from cd59000badb24fe9b0a6be22f5db252a', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "cd59000badb24fe9b0a6be22f5db252a", "dataset_name": "cd59000badb24fe9b0a6be22f5db252a", "query": "select * from cd59000badb24fe9b0a6be22f5db252a limit 10;"}', 'triformer_10_output2023-09-27 16:09:36');
INSERT INTO "public"."dataset" VALUES (30, 'select * from a140e4423a6f427b97454b9237b4ad42', 'null', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "a140e4423a6f427b97454b9237b4ad42", "dataset_name": "a140e4423a6f427b97454b9237b4ad42", "query": "select * from a140e4423a6f427b97454b9237b4ad42 limit 10;"}', 'a140e4423a6f427b97454b9237b4ad42');
INSERT INTO "public"."dataset" VALUES (31, 'select * from dd93e8a50b27483bb00f0f84f6f4103f', '{"x": 1, "y": 0.2}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "dd93e8a50b27483bb00f0f84f6f4103f", "example_row": {"x": 1, "y": 0.2}, "dataset_name": "dd93e8a50b27483bb00f0f84f6f4103f", "query": "select * from dd93e8a50b27483bb00f0f84f6f4103f limit 10;"}', 'dd93e8a50b27483bb00f0f84f6f4103f');
INSERT INTO "public"."dataset" VALUES (32, 'select * from 25344729544b4737bdf0043026456622', '{"x": 1, "y": 0.2}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "25344729544b4737bdf0043026456622", "example_row": {"x": 1, "y": 0.2}, "dataset_name": "25344729544b4737bdf0043026456622", "query": "select * from 25344729544b4737bdf0043026456622 limit 10;"}', '25344729544b4737bdf0043026456622');
INSERT INTO "public"."dataset" VALUES (33, 'select * from 6ce68394a37349cb95094e629e19e127', '{"x": 1, "y": 0.2,"z": 0.3}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "6ce68394a37349cb95094e629e19e127", "example_row": {"x": 1, "y": 0.2}, "dataset_name": "6ce68394a37349cb95094e629e19e127", "query": "select * from 6ce68394a37349cb95094e629e19e127 limit 10;"}', '6ce68394a37349cb95094e629e19e127');
INSERT INTO "public"."dataset" VALUES (34, 'select * from 9309136629e2410aa31d20b100016bda', '{"x": 1, "y": 0.2,"z": 0.3}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "9309136629e2410aa31d20b100016bda", "example_row": {"x": 1, "y": 0.2}, "dataset_name": "9309136629e2410aa31d20b100016bda", "query": "select * from 9309136629e2410aa31d20b100016bda limit 10;"}', '9309136629e2410aa31d20b100016bda');
INSERT INTO "public"."dataset" VALUES (35, 'select * from 55d01a8e2433422c9560dcc8b89e7f93', '{"x": 1, "y": 0.2, "z": 0.3}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "55d01a8e2433422c9560dcc8b89e7f93", "example_row": {"x": 1, "y": 0.2, "z": 0.3}, "dataset_name": "55d01a8e2433422c9560dcc8b89e7f93", "query": "select * from 55d01a8e2433422c9560dcc8b89e7f93 limit 10;"}', '55d01a8e2433422c9560dcc8b89e7f93');
INSERT INTO "public"."dataset" VALUES (36, 'select * from 957cf7dae6614e37808d9b5511ceca37', '{"x": 1, "y": 0.2, "z": 0.3}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "957cf7dae6614e37808d9b5511ceca37", "example_row": {"x": 1, "y": 0.2, "z": 0.3}, "dataset_name": "957cf7dae6614e37808d9b5511ceca37", "query": "select * from 957cf7dae6614e37808d9b5511ceca37;"}', '957cf7dae6614e37808d9b5511ceca37');
INSERT INTO "public"."dataset" VALUES (37, 'select * from 692158261ff34120842bc6c9b2d4174d', '{"x": 1, "y": 0.2, "z": 0.3}', '{"host": "113.31.110.212", "port": "3306", "user": "root", "password": "zzh0117.", "database": "db11", "table_name": "692158261ff34120842bc6c9b2d4174d", "example_row": {"x": 1, "y": 0.2, "z": 0.3}, "dataset_name": "692158261ff34120842bc6c9b2d4174d", "query": "select * from 692158261ff34120842bc6c9b2d4174d"}', '692158261ff34120842bc6c9b2d4174d');

-- ----------------------------
-- Primary Key structure for table dataset
-- ----------------------------
ALTER TABLE "public"."dataset" ADD CONSTRAINT "dataset_pkey" PRIMARY KEY ("datasetid");
