# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc", "mrt", "cong_eff_pc", "cong_eff_mrt", "cong_eff_ies", "cong_eff_rcs", "cong_eff_lisas", "pc_inc", "pc_con", "mrt_inc", "mrt_con", "ies_inc", "ies_con", "rcs_inc", "rcs_con", "lisas_inc", "lisas_con"]
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
          "value": [0.65]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.46857524]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.04166667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.2359454]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.51529535]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.18172322]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.91303287]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.66666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.625]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.37782701]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.61377242]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.06674052]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.58203586]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.64688051]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.46515729]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.05795214]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.97098502]
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
          "value": ["id", "pc", "mrt", "cong_eff_pc", "cong_eff_mrt", "cong_eff_ies", "cong_eff_rcs", "cong_eff_lisas", "pc_inc", "pc_con", "mrt_inc", "mrt_con", "ies_inc", "ies_con", "rcs_inc", "rcs_con", "lisas_inc", "lisas_con"]
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
          "value": [0.65, 0.65]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.46857524, 1.13717124]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.04166667, 0.16666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.2359454, 0.09944621]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.51529535, 0.58328809]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.18172322, -0.03772485]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.91303287, 0.07092664]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.66666667, 0.58333333]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.625, 0.75]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.37782701, 1.18306949]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.61377242, 1.08362328]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.06674052, 2.02811912]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.58203586, 1.44483104]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.64688051, 0.55743769]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.46515729, 0.51971284]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.05795214, 1.71137251]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.97098502, 1.64044587]
        }
      ]
    }

# Works when condition missing

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc", "mrt", "cong_eff_pc", "cong_eff_mrt", "cong_eff_ies", "cong_eff_rcs", "cong_eff_lisas", "pc_inc", "pc_con", "mrt_inc", "mrt_con", "ies_inc", "ies_con", "rcs_inc", "rcs_con", "lisas_inc", "lisas_con"]
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
          "value": [0.51]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.93044958]
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
          "value": [0.51]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.93044958]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.82441094]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.52907009]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.74401418]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        }
      ]
    }

