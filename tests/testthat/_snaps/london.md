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
          "value": ["prop_perfect", "mrt_init"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [6103.24580517]
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
          "value": ["id", "prop_perfect", "mrt_init"]
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
          "value": [0.5, 0.5, 0.375, 0.6875, 0.5625]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [6103.24580517, 14984.08032395, 7408.84353434, 7304.73031148, 16296.3523567]
        }
      ]
    }

