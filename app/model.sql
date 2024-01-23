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

 Date: 22/01/2024 20:59:48
*/


-- ----------------------------
-- Table structure for model
-- ----------------------------
DROP TABLE IF EXISTS "public"."model";
CREATE TABLE "public"."model" (
  "id" int4 NOT NULL DEFAULT nextval('model_id_seq'::regclass),
  "model_name" varchar(255) COLLATE "pg_catalog"."default",
  "model_config" json
)
;

-- ----------------------------
-- Records of model
-- ----------------------------
INSERT INTO "public"."model" VALUES (1, 'triformer', '{
    "model": "PA",
    "data": "ETTh1",
    "root_path": "./data/ETT/",
    "data_path": "ETTh1.csv",
    "features": "M",
    "target": "OT",
    "freq": "h",
    "seq_len": 24,
    "label_len": 48,
    "pred_len": 24,
    "enc_in": 7,
    "dec_in": 7,
    "c_out": 7,
    "d_model": 512,
    "n_heads": 8,
    "e_layers": 2,
    "d_layers": 1,
    "s_layers": [
        3,
        2,
        1
    ],
    "d_ff": 2048,
    "factor": 5,
    "padding": 0,
    "distil": true,
    "dropout": 0.05,
    "attn": "prob",
    "embed": "timeF",
    "activation": "gelu",
    "output_attention": false,
    "do_predict": false,
    "mix": true,
    "cols": "None",
    "num_workers": 0,
    "itr": 2,
    "train_epochs": 6,
    "batch_size": 32,
    "patience": 3,
    "learning_rate": 0.0001,
    "des": "test",
    "loss": "mse",
    "lradj": "type1",
    "use_amp": false,
    "inverse": false,
    "use_gpu": true,
    "use_multi_gpu": false,
    "devices": "0,1",
    "detail_freq": "h",
    "input": [
        {
            "value": "date",
            "label": "x",
            "type": "select",
            "desc": "横坐标,用于表示时序"
        },
        {
            "value": "X",
            "label": "y_true",
            "type": "select",
            "desc": "纵坐标,用于表示实际值"
        }
    ],
    "example": {
        "type": "TSL",
        "dataset": {
            "config": {
                "host": "113.31.110.212",
                "port": "5432",
                "user": "zzh",
                "password": "zzh0117.",
                "type": "psql",
                "database": "al",
                "query": "\nselect * from test;\n\n\n\n\n\n\n\n\n\n\n\n\n"
            }
        },
        "mapping": {
            "X_predict":["y_pred"],
            "X":["y"],
            "date":["time"]
        }
    }
}
');
INSERT INTO "public"."model" VALUES (4, 'PatchTST', NULL);
INSERT INTO "public"."model" VALUES (5, 'merlion_isolationforest', NULL);
INSERT INTO "public"."model" VALUES (6, 'AnomalyTransformer', NULL);
INSERT INTO "public"."model" VALUES (7, 'tods_lofski', NULL);
INSERT INTO "public"."model" VALUES (8, 'DCdetector', NULL);
INSERT INTO "public"."model" VALUES (9, 'FEDformer', NULL);
INSERT INTO "public"."model" VALUES (10, 'FiLM', NULL);
INSERT INTO "public"."model" VALUES (11, 'Informer', NULL);
INSERT INTO "public"."model" VALUES (12, 'Linear', NULL);
INSERT INTO "public"."model" VALUES (13, 'merlion_autoencoder', NULL);
INSERT INTO "public"."model" VALUES (14, 'merlion_deeppointanomalydetector', NULL);
INSERT INTO "public"."model" VALUES (15, 'merlion_lstmed', NULL);
INSERT INTO "public"."model" VALUES (16, 'merlion_vae', NULL);
INSERT INTO "public"."model" VALUES (17, 'NLinear', NULL);
INSERT INTO "public"."model" VALUES (18, 'Nonstationary_Transformer', NULL);
INSERT INTO "public"."model" VALUES (19, 'TimesNet', NULL);
INSERT INTO "public"."model" VALUES (20, 'MIDD', NULL);
INSERT INTO "public"."model" VALUES (21, 'tods_ocsvmski', NULL);

-- ----------------------------
-- Primary Key structure for table model
-- ----------------------------
ALTER TABLE "public"."model" ADD CONSTRAINT "model_pkey" PRIMARY KEY ("id");
