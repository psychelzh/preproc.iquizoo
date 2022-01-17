# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc", "mrt", "dist_eff"]
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
          "value": [0.50555556]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [836.33075214]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-71.67276679]
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
          "value": ["id", "pc", "mrt", "dist_eff"]
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
          "value": [0.54166667, 0.47222222, 0.44444444, 0.56944444, 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [883.40845768, 907.30660384, 748.03678584, 766.83129424, 814.36809532]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-111.21898819, -66.27699718, -86.66171062, -92.63997343, -19.74852742]
        }
      ]
    }

