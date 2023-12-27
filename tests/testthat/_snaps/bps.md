# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc", "p_sim_target", "p_sim_lure", "p_sim_foil", "bps_score"]
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
          "value": [0.36666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.35]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.05]
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
          "value": ["id", "pc", "p_sim_target", "p_sim_lure", "p_sim_foil", "bps_score"]
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
          "value": [0.36666667, 0.31666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.25, 0.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4, 0.3]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.35, 0.3]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.05, 0]
        }
      ]
    }

