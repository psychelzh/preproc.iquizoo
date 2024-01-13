# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc", "mrt", "switch_cost_pc", "switch_cost_mrt", "switch_cost_ies", "switch_cost_rcs", "switch_cost_lisas", "pc_switch", "pc_repeat", "mrt_switch", "mrt_repeat", "ies_switch", "ies_repeat", "rcs_switch", "rcs_repeat", "lisas_switch", "lisas_repeat"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1]
        },
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [0.525]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.98162192]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.06]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.18532587]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.56280826]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.07827733]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.63462839]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.56]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.89673044]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.0820563]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.60130435]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.16411261]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.61044147]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.53216414]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.55124]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.1858684]
        }
      ]
    }

# Works with grouping variable

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "pc", "mrt", "switch_cost_pc", "switch_cost_mrt", "switch_cost_ies", "switch_cost_rcs", "switch_cost_lisas", "pc_switch", "pc_repeat", "mrt_switch", "mrt_repeat", "ies_switch", "ies_repeat", "rcs_switch", "rcs_repeat", "lisas_switch", "lisas_repeat"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2]
        },
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
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
          "value": [0.525, 0.44166667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.98162192, 0.73929822]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.06, -0.12068966]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.18532587, 0.02251054]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.56280826, -0.42885569]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.07827733, -0.03205385]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.63462839, -0.30092333]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.56, 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5, 0.37931034]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.89673044, 0.76717403]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.0820563, 0.74466349]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.60130435, 1.53434806]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.16411261, 1.96320375]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.61044147, 0.5234727]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.53216414, 0.49141884]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.55124, 1.42575584]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.1858684, 1.72667917]
        }
      ]
    }

# Works when condition missing

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
          "value": ["pc", "mrt", "switch_cost_pc", "switch_cost_mrt", "switch_cost_ies", "switch_cost_rcs", "switch_cost_lisas", "pc_switch", "pc_repeat", "mrt_switch", "mrt_repeat", "ies_switch", "ies_repeat", "rcs_switch", "rcs_repeat", "lisas_switch", "lisas_repeat"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [0.525]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.98830673]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.525]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.98830673]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.88248901]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5520562]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.70138519]
        }
      ]
    }

