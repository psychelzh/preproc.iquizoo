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
          "value": ["mean_abs_err", "mean_log_err"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [28.75]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.91915827]
        }
      ]
    }

# Works with grouping variable

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
          "value": ["id", "mean_abs_err", "mean_log_err"]
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
          "value": [28.75, 23.05]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.91915827, 2.66233123]
        }
      ]
    }

