# Works without grouping variables

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["capacity0", "capacity2", "capacity", "efficiency"]
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
          "value": [4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [5.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.625]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-1.25]
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
          "value": ["id", "capacity0", "capacity2", "capacity", "efficiency"]
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
          "value": [4, 4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [5.25, 5.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.625, 4.625]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-1.25, -1.25]
        }
      ]
    }

