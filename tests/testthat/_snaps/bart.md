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
          "value": ["mean_pumps", "mean_pumps_raw", "num_explosion"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [2.052]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.988]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [250]
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
          "value": ["id", "mean_pumps", "mean_pumps_raw", "num_explosion"]
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
          "value": [2.25, 2.09259259, 1.65306122, 2.35555556, 1.89130435]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.02, 2.07, 1.73, 2.07, 2.05]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [44, 46, 51, 55, 54]
        }
      ]
    }

