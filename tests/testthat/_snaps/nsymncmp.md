# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc", "mrt", "w"]
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
          "value": [0.4975]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [907.39682551]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
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
          "value": ["id", "pc", "mrt", "w"]
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
          "value": [0.525, 0.5, 0.4625, 0.5, 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [897.61656614, 898.05717178, 956.63541716, 965.72132845, 885.25572289]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA", "NA", 9.09482217, 3.48272068]
        }
      ]
    }

