# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc", "mrt", "dprime", "c"]
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
          "value": [0.53]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [869.78024183]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.14762737]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.02464431]
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
          "value": ["id", "pc", "mrt", "dprime", "c"]
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
          "value": [0.4, 0.5, 0.65, 0.6, 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [693.91489692, 877.15654466, 901.94745903, 582.01721861, 1277.81815812]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.45976824, 0, 0.70267324, 0.47278912, 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-5.55111512e-17, 0.22988412, -0.1214525, -0.23639456, -0]
        }
      ]
    }

