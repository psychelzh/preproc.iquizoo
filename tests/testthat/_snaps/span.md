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
          "value": ["nc", "max_span", "mean_span_pcu", "mean_span_anu"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [466]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [14]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [12.98183622]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [12.62449495]
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
          "value": ["id", "nc", "max_span", "mean_span_pcu", "mean_span_anu"]
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
          "value": [74, 89, 79, 118, 106]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [10, 12, 10, 14, 13]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.51111111, 11.38095238, 9.83549784, 13.70833333, 13.35714286]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.58333333, 11.66666667, 9.5, 14, 13]
        }
      ]
    }

