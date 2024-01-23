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

 Date: 22/01/2024 20:59:37
*/


-- ----------------------------
-- Table structure for datasource
-- ----------------------------
DROP TABLE IF EXISTS "public"."datasource";
CREATE TABLE "public"."datasource" (
  "datasourceid" int4 NOT NULL DEFAULT nextval('datasource_datasourceid_seq'::regclass),
  "config" json NOT NULL
)
;

-- ----------------------------
-- Records of datasource
-- ----------------------------
INSERT INTO "public"."datasource" VALUES (2, '{"host":"113.31.110.212","port":3306,"user":"root","password":"zzh0117.","type":"mysql","database":"db11"}');

-- ----------------------------
-- Primary Key structure for table datasource
-- ----------------------------
ALTER TABLE "public"."datasource" ADD CONSTRAINT "datasource_pkey" PRIMARY KEY ("datasourceid");
