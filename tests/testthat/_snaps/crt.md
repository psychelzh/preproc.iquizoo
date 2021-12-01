# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "nc", "mrt", "rtsd"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5]
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
          "value": [1, 2, 3, 4, 5]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [21, 42, 19, 36, 34]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [818.75313763, 880.17268286, 907.15700641, 899.66472402, 992.11720112]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [490.53860724, 624.01052673, 723.80850936, 635.747919, 816.64348878]
        }
      ]
    }

# Works with multiple grouping variables

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "id1", "nc", "mrt", "rtsd"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5]
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
          "value": [1, 2, 3, 4, 5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [2, 3, 4, 5, 6]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [21, 42, 19, 36, 34]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [818.75313763, 880.17268286, 907.15700641, 899.66472402, 992.11720112]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [490.53860724, 624.01052673, 723.80850936, 635.747919, 816.64348878]
        }
      ]
    }

