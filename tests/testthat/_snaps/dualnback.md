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
          "value": [715.80462828]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [845.34232155]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [804.28578491]
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
          "value": [715.80462828, 1497.2699528, 627.76512771, 1350.91860516, 509.63538732]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [845.34232155, 1165.34102278, 830.26158773, 1162.75098803, 1025.25723844]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [804.28578491, 833.41209277, 878.57534355, 1016.39839693, 1330.69111254]
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

