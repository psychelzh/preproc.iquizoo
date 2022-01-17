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
          "value": ["pc_aud", "pc_both", "pc_vis", "mrt_aud", "mrt_both", "mrt_vis", "dprime_aud", "dprime_both", "dprime_vis", "c_aud", "c_both", "c_vis"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [0.4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.45]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1098.66053403]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [715.20579362]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [967.78388097]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.45976824]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.24104039]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-5.55111512e-17]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.1205202]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.22988412]
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
          "value": ["id", "pc_aud", "pc_both", "pc_vis", "mrt_aud", "mrt_both", "mrt_vis", "dprime_aud", "dprime_both", "dprime_vis", "c_aud", "c_both", "c_vis"]
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
          "value": [0.4, 0.65, 0.5, 0.55, 0.45]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.45, 0.625, 0.5, 0.475, 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5, 0.6, 0.5, 0.4, 0.55]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1098.66053403, 1676.06560382, 843.31273462, 366.8532792, 712.98995601]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [715.20579362, 1092.0622753, 824.42419432, 491.82720026, 856.60412827]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [967.78388097, 508.05894678, 792.94329382, 648.04460159, 1028.94113498]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.45976824, 0.70267324, 0, 0.22988412, -0.242905]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.24104039, 0.61684868, 0, -0.11964811, 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0, 0.47278912, 0, -0.45976824, 0.22988412]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-5.55111512e-17, -0.1214525, -0, 0.11494206, -0.35133662]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.1205202, -0.18877623, 0.11964811, 0.05982406, -0.11964811]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.22988412, -0.23639456, 0.22988412, -5.55111512e-17, 0.11494206]
        }
      ]
    }

