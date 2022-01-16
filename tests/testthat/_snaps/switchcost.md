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
          "value": [1, 2, 3, 4, 5]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "mrt_pure", "mrt_repeat", "mrt_switch", "pc_pure", "pc_repeat", "pc_switch", "switch_cost_rt_gen", "switch_cost_rt_spe", "switch_cost_pc_gen", "switch_cost_pc_spe"]
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
          "value": [698.12917932, 736.72302089, 829.89654777, 884.54250414, 890.01715617]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [711.72529961, 1134.53444259, 724.15149857, 913.06409888, 772.87122822]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [758.11465886, 791.26581079, 1078.2811424, 964.74797026, 886.35741309]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.52009804, 0.48083624, 0.44453005, 0.46573427, 0.50034153]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.55319149, 0.56923077, 0.4, 0.58333333, 0.53333333]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5106383, 0.45614035, 0.37704918, 0.60344828, 0.55072464]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [13.59612029, 397.8114217, -105.74504921, 28.52159474, -117.14592794]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [46.38935926, -343.2686318, 354.12964383, 51.68387138, 113.48618487]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.03309345, 0.08839453, -0.04453005, 0.11759907, 0.0329918]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.04255319, -0.11309042, -0.02295082, 0.02011494, 0.0173913]
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
          "value": ["id", "mrt_pure", "mrt_repeat", "mrt_switch", "pc_pure", "pc_repeat", "pc_switch", "switch_cost_rt_gen", "switch_cost_rt_spe", "switch_cost_pc_gen", "switch_cost_pc_spe"]
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
          "value": [846.55881728, 1189.70317602]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [975.73875114, 989.30554671]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5, 0.4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4375, 0.6125]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [129.17993386, -200.3976293]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.0625, 0.2125]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
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
          "value": ["id", "mrt_pure", "mrt_repeat", "mrt_switch", "pc_pure", "pc_repeat", "pc_switch", "switch_cost_rt_gen", "switch_cost_rt_spe", "switch_cost_pc_gen", "switch_cost_pc_spe"]
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
          "value": [698.12917932, 736.72302089, 829.89654777, 884.54250414, 890.01715617]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [711.72529961, 1134.53444259, 724.15149857, 913.06409888, 772.87122822]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [758.11465886, 791.26581079, 1078.2811424, 964.74797026, 886.35741309]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.52009804, 0.48083624, 0.44453005, 0.46573427, 0.50034153]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.55319149, 0.56923077, 0.4, 0.58333333, 0.53333333]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5106383, 0.45614035, 0.37704918, 0.60344828, 0.55072464]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [13.59612029, 397.8114217, -105.74504921, 28.52159474, -117.14592794]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [46.38935926, -343.2686318, 354.12964383, 51.68387138, 113.48618487]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.03309345, 0.08839453, -0.04453005, 0.11759907, 0.0329918]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.04255319, -0.11309042, -0.02295082, 0.02011494, 0.0173913]
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
          "value": ["id", "mrt_pure", "mrt_repeat", "mrt_switch", "pc_pure", "pc_repeat", "pc_switch", "switch_cost_rt_gen", "switch_cost_rt_spe", "switch_cost_pc_gen", "switch_cost_pc_spe"]
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
          "value": [509.54578417, 735.04662597]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [945.42574901, 1024.32861317]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 722.65357529]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.45, 0.65]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5125, 0.725]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 0.6]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [435.87996484, 289.2819872]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", -301.67503787]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.0625, 0.075]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", -0.125]
        }
      ]
    }

# Can deal with data without 'pure' blocks

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
          "value": ["mrt_pure", "mrt_repeat", "mrt_switch", "pc_pure", "pc_repeat", "pc_switch", "switch_cost_rt_gen", "switch_cost_rt_spe", "switch_cost_pc_gen", "switch_cost_pc_spe"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [635.4873299]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1099.26415708]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.55]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [463.77682718]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.05]
        }
      ]
    }

