# Works without grouping variables

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
          "value": ["k", "k3", "k5", "k7", "k9"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [1.43333333]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-1.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-1.66666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [3.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [5.4]
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
          "value": [1, 2]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "k", "k3", "k5", "k7", "k9"]
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
          "value": [1.43333333, 0.1875]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-1.5, -0.75]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-1.66666667, 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [3.5, 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [5.4, 1.5]
        }
      ]
    }

