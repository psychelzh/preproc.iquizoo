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
          "value": [936.36601911, 935.34955135, 866.41622014, 872.64978762, 897.11225902]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1245.67991876, 1300.22543836, 750.66179195, 988.09177614, 826.59734741]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [856.86031781, 871.95969076, 1103.0138547, 1130.24789119, 1183.15542589]
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
          "value": [309.31389965, 364.87588701, -115.75442819, 115.44198852, -70.51491161]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-388.81960095, -428.2657476, 352.35206275, 142.15611505, 356.55807848]
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
          "value": [1076.99044369, 1881.8149895]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1491.43911209, 687.5225916]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5, 0.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.25, 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [414.44866841, -1194.2923979]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", "NaN"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.25, 0.25]
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
          "value": [936.36601911, 935.34955135, 866.41622014, 872.64978762, 897.11225902]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1245.67991876, 1300.22543836, 750.66179195, 988.09177614, 826.59734741]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [856.86031781, 871.95969076, 1103.0138547, 1130.24789119, 1183.15542589]
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
          "value": [309.31389965, 364.87588701, -115.75442819, 115.44198852, -70.51491161]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-388.81960095, -428.2657476, 352.35206275, 142.15611505, 356.55807848]
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
          "value": [1349.24823179, 1195.36595693]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1638.22327441, 482.47219659]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 1107.83010624]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5, 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.25, 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [288.97504262, -712.89376034]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 625.35790965]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.25, 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NaN", 0]
        }
      ]
    }

