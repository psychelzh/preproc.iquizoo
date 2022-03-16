# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["rt_nth", "ssrt", "pc_all", "pc_go", "pc_stop"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1]
        },
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [402.54432129]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [66.08598795]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.6875]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.71666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.6]
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
          "value": ["id", "rt_nth", "ssrt", "pc_all", "pc_go", "pc_stop"]
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
          "value": [402.54432129, 641.07509227, 439.41262477, 737.23881173, 683.47292117]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [66.08598795, 255.17765637, 148.25100861, 180.49277999, 158.14824585]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.6875, 0.6125, 0.6375, 0.55625, 0.625]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.71666667, 0.68333333, 0.675, 0.625, 0.7]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.6, 0.4, 0.525, 0.35, 0.4]
        }
      ]
    }

