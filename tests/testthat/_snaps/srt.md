# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "mrt", "rtsd"]
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
          "value": [814.1916073, 1040.89678046, 1119.81064654, 869.66874426, 915.00215731]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [508.81168373, 784.73173135, 797.14890178, 587.02948357, 622.56938052]
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
          "value": ["id", "id1", "mrt", "rtsd"]
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
          "type": "double",
          "attributes": {},
          "value": [814.1916073, 1040.89678046, 1119.81064654, 869.66874426, 915.00215731]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [508.81168373, 784.73173135, 797.14890178, 587.02948357, 622.56938052]
        }
      ]
    }

