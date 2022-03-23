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
          "value": ["still_ratio"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [0.22503122]
        }
      ]
    }

# No error for negative duration case (but produces `NA`s)

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
          "value": ["still_ratio"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        }
      ]
    }

