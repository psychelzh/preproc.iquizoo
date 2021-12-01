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
          "value": ["sum_outcome", "perc_good"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [494800]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.53468208]
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
          "value": ["id", "sum_outcome", "perc_good"]
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
          "value": [66800, 129000, 72000, 118600, 108400]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.62264151, 0.48863636, 0.48, 0.55421687, 0.54166667]
        }
      ]
    }

