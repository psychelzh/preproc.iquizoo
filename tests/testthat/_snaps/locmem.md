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
          "value": ["id", "nc_loc", "mean_dist_err", "mean_log_err"]
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
          "value": [5.29306452, 5.15967742, 5.00342105, 4.71106383, 4.347]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.72903044, 1.70345254, 1.68068155, 1.62737885, 1.49997902]
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
          "value": ["id", "id1", "nc_loc", "mean_dist_err", "mean_log_err"]
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
          "value": [5.29306452, 5.15967742, 5.00342105, 4.71106383, 4.347]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.72903044, 1.70345254, 1.68068155, 1.62737885, 1.49997902]
        }
      ]
    }

