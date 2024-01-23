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

 Date: 22/01/2024 20:59:23
*/


-- ----------------------------
-- Table structure for chart_template
-- ----------------------------
DROP TABLE IF EXISTS "public"."chart_template";
CREATE TABLE "public"."chart_template" (
  "cid" int4 NOT NULL,
  "chart_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "config" json
)
;

-- ----------------------------
-- Records of chart_template
-- ----------------------------
INSERT INTO "public"."chart_template" VALUES (1, 'TSL', '{
    "template":[
        {"value":"date","label":"x" ,"type":"select","desc":"横坐标,用于表示时序"},
        {"value":"X","label":"y_true","type":"select","desc":"纵坐标,用于表示实际值"},
        {"value":"X_predict","label":"y_pred","type":"select","desc":"纵坐标,用于表示预测值"},
        {"value":"z", "type":"number","label":"input","desc":"预测值与实际值的阈值"}
    ]
}');
INSERT INTO "public"."chart_template" VALUES (2, 'LPC', '{
    "template":[
        {"value":"date","label":"date" ,"type":"select","desc":"横坐标,用于表示时序"},
      {"value":"x_predict","label":"x_predict","type":"select","desc":"纵坐标,用于表示predict"},

        {"value":"x_orient","label":"x_orient","type":"select","desc":"纵坐标,用于表示实际值"}
    ]
}');
INSERT INTO "public"."chart_template" VALUES (3, 'Table', '{
    "template":[
        {"value":"columns","label":"columns" ,"type":"select","desc":"要展示的时序列"}
    ]
}');

-- ----------------------------
-- Primary Key structure for table chart_template
-- ----------------------------
ALTER TABLE "public"."chart_template" ADD CONSTRAINT "chart_template_pkey" PRIMARY KEY ("cid");
