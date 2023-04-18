# Works without grouping variables

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["fnn", "fno", "fntotal"]
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
          "value": [7]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [11]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [18]
        }
      ]
    }

# Works with grouping variables

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "fnn", "fno", "fntotal"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2]
        },
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
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
          "value": [7, 7]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [11, 11]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [18, 18]
        }
      ]
    }

