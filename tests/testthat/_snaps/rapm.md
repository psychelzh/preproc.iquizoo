# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["nc_prac", "nc_test", "nc_total"]
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
          "type": "integer",
          "attributes": {},
          "value": [9]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [31]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [40]
        }
      ]
    }

# Works with grouping variable

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "nc_prac", "nc_test", "nc_total"]
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
          "type": "integer",
          "attributes": {},
          "value": [9, 11]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [31, 29]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [40, 40]
        }
      ]
    }

