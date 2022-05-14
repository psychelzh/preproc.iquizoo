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
          "value": [0.93774369]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.06]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.10482157]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.40179966]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.0225474]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.47025281]
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
          "value": [1.00155201]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.60130435]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.00310401]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.61044147]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.58789408]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.55124]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.02149282]
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
          "value": [0.93774369, 0.69227237]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.06, -0.12068966]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.10482157, -0.06214812]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.40179966, -0.59817302]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.0225474, -0.11517035]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.47025281, -0.55634542]
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
          "value": [0.89673044, 0.68251537]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.00155201, 0.74466349]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.60130435, 1.36503074]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.00310401, 1.96320375]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.61044147, 0.60658919]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.58789408, 0.49141884]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.55124, 1.17033375]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.02149282, 1.72667917]
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

