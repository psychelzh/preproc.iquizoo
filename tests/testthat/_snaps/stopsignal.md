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
          "value": ["pc_all", "pc_go", "medrt_go", "ssrt"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [0.51875]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [781.74856824]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [340.4291238]
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
          "value": ["id", "pc_all", "pc_go", "medrt_go", "ssrt"]
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
          "value": [0.51875, 0.4375, 0.525, 0.50625, 0.525]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51666667, 0.425, 0.48333333, 0.475, 0.53333333]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [781.74856824, 996.6744361, 660.24329467, 745.25551284, 777.82834289]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [340.4291238, 412.58352701, 215.99726292, 282.1144872, 352.47120003]
        }
      ]
    }

