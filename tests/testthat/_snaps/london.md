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
          "value": [10474, 11534, 11799, 14999, 13699]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [7.5, 7.66666667, 6.83333333, 8, 7.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.83424403, 2.11135856, 1.84628848, 1.82646698, 1.73319847]
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
          "value": ["id", "id1", "total_score", "mean_level", "level_score"]
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
          "value": [10474, 11534, 11799, 14999, 13699]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [7.5, 7.66666667, 6.83333333, 8, 7.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.83424403, 2.11135856, 1.84628848, 1.82646698, 1.73319847]
        }
      ]
    }

