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
          "value": ["total_score", "mean_level", "level_score"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [61274]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [7.53838384]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2.13625378]
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
          "value": ["id", "total_score", "mean_level", "level_score"]
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
          "value": [10891, 11725, 9765, 14968, 13925]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [7.58333333, 7.66666667, 7.41666667, 8.375, 7.85714286]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.85090148, 1.97169759, 2.16708353, 1.99730032, 1.79982078]
        }
      ]
    }

