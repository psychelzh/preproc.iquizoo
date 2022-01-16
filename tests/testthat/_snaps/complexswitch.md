# Default behavior works

    {
      "type": "list",
      "attributes": {
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["mrt_inc", "mrt_con", "pc_inc", "pc_con", "cong_eff_rt", "cong_eff_pc", "mrt_pure", "mrt_repeat", "mrt_switch", "pc_pure", "pc_repeat", "pc_switch", "switch_cost_rt_gen", "switch_cost_rt_spe", "switch_cost_pc_gen", "switch_cost_pc_spe"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [1065.01418556]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1002.42540143]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.49905838]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51102941]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [62.58878413]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.01197103]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [880.1374934]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [814.12625666]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1129.38433511]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.48541667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.53146853]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51535836]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-66.01123674]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [315.25807846]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.04605186]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.01611017]
        }
      ]
    }

# Works with grouping variables

    {
      "type": "list",
      "attributes": {
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "mrt_inc", "mrt_con", "pc_inc", "pc_con", "cong_eff_rt", "cong_eff_pc", "mrt_pure", "mrt_repeat", "mrt_switch", "pc_pure", "pc_repeat", "pc_switch", "switch_cost_rt_gen", "switch_cost_rt_spe", "switch_cost_pc_gen", "switch_cost_pc_spe"]
        }
      },
      "value": [
        {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1102.47217774, 828.96532866, 1328.83256813, 1094.75822291, 1041.29556184]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1073.35773927, 908.262925, 801.17342319, 1006.68700963, 1257.76721328]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.44047619, 0.47826087, 0.53153153, 0.50420168, 0.52941176]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.62352941, 0.49074074, 0.42857143, 0.52845528, 0.50862069]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [29.11443847, -79.29759635, 527.65914494, 88.07121328, -216.47165144]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.18305322, 0.01247987, -0.1029601, 0.0242536, -0.02079108]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [737.54702956, 685.05072065, 898.11910009, 975.41307144, 984.12486176]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [810.83641677, 603.13284517, 996.55464413, 882.82339333, 960.17347835]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1234.97315713, 1092.77335323, 1042.5320565, 999.13955071, 1222.50682915]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.47009804, 0.46297909, 0.46475347, 0.49020979, 0.55840164]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.58139535, 0.60606061, 0.43636364, 0.46551724, 0.5625]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.56862745, 0.35714286, 0.57377049, 0.61666667, 0.46153846]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [73.28938721, -81.91787547, 98.43554404, -92.5896781, -23.95138341]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [424.13674036, 489.64050806, 45.97741236, 116.31615737, 262.33335081]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.11129731, 0.14308151, -0.02838983, -0.02469255, 0.00409836]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.0127679, -0.24891775, 0.13740686, 0.15114943, -0.10096154]
        }
      ]
    }

# All single condition

    {
      "type": "list",
      "attributes": {
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "mrt_inc", "mrt_con", "pc_inc", "pc_con", "cong_eff_rt", "cong_eff_pc", "mrt_pure", "mrt_repeat", "mrt_switch", "pc_pure", "pc_repeat", "pc_switch", "switch_cost_rt_gen", "switch_cost_rt_spe", "switch_cost_pc_gen", "switch_cost_pc_spe"]
        }
      },
      "value": [
        {
          "type": "integer",
          "attributes": {},
          "value": [1, 2]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [655.12096416, 1043.49021131]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.45, 0.46]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [771.98410631, 1748.19268996]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [514.89295126, 865.43240464]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4, 0.4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4625, 0.475]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-257.09115505, -882.76028532]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.0625, 0.075]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        }
      ]
    }

# Part subject single condition

    {
      "type": "list",
      "attributes": {
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "mrt_inc", "mrt_con", "pc_inc", "pc_con", "cong_eff_rt", "cong_eff_pc", "mrt_pure", "mrt_repeat", "mrt_switch", "pc_pure", "pc_repeat", "pc_switch", "switch_cost_rt_gen", "switch_cost_rt_spe", "switch_cost_pc_gen", "switch_cost_pc_spe"]
        }
      },
      "value": [
        {
          "type": "integer",
          "attributes": {},
          "value": [1, 2]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1140.01244561, 601.40370713]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", 939.73582127]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.43, 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", 0.6]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", -338.33211414]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", 0.1]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1115.08223497, 788.99826483]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1011.05303656, 662.48843471]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 807.59845997]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.35, 0.3]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.45, 0.6]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 0.625]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-104.02919841, -126.50983011]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 145.11002526]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.1, 0.3]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 0.025]
        }
      ]
    }

