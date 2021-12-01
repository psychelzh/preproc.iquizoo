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
          "value": ["id", "nc", "mean_ang_err", "mean_log_err"]
        }
      },
      "value": [
        {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [0, 0, 0, 0, 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [56.25, 52.5, 53.25, 40.5, 38.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.67644898, 0.64847183, 0.64173418, 0.51546423, 0.50243359]
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
          "value": ["id", "id1", "nc", "mean_ang_err", "mean_log_err"]
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
          "type": "integer",
          "attributes": {},
          "value": [0, 0, 0, 0, 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [56.25, 52.5, 53.25, 40.5, 38.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.67644898, 0.64847183, 0.64173418, 0.51546423, 0.50243359]
        }
      ]
    }

