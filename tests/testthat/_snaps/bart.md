# Works as expected

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
          "value": ["mean_pumps", "mean_pumps_raw", "num_explosion"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [10]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [10]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [2]
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
          "value": ["id", "mean_pumps", "mean_pumps_raw", "num_explosion"]
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
          "value": [10, 10]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [10, 10]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [2, 2]
        }
      ]
    }

