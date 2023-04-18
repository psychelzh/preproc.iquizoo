# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["nc", "max_span", "mean_span_pcu", "mean_span_anu"]
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
          "value": [77]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [10]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.67222222]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.58333333]
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
          "value": ["id", "nc", "max_span", "mean_span_pcu", "mean_span_anu"]
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
          "type": "double",
          "attributes": {},
          "value": [77, 94]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [10, 12]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.67222222, 11.67460317]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.58333333, 11.66666667]
        }
      ]
    }

# Works when no acc column found

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
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [10]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.58333333]
        }
      ]
    }

---

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
          "value": [16]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [10]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.26349206]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.58333333]
        }
      ]
    }

# Can restore outcome from correctness

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["nc", "max_span", "mean_span_pcu", "mean_span_anu"]
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
          "value": [35]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [5.36666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.75]
        }
      ]
    }

