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
          "value": ["id", "pc", "p_sim_foil", "p_sim_lure", "p_sim_target", "bps_score"]
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
          "value": [0.3, 0.36666667, 0.4, 0.25, 0.31666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.2, 0.2, 0.3, 0.4, 0.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.35, 0.4, 0.5, 0.25, 0.4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5, 0.4, 0.45, 0.35, 0.35]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.15, 0.2, 0.2, -0.15, 0.15]
        }
      ]
    }

# Works with multiple grouping variables

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
          "value": ["id", "id1", "pc", "p_sim_foil", "p_sim_lure", "p_sim_target", "bps_score"]
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
          "value": [2, 3, 4, 5, 6]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.3, 0.36666667, 0.4, 0.25, 0.31666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.2, 0.2, 0.3, 0.4, 0.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.35, 0.4, 0.5, 0.25, 0.4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5, 0.4, 0.45, 0.35, 0.35]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.15, 0.2, 0.2, -0.15, 0.15]
        }
      ]
    }

