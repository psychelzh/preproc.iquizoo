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
          "value": [1, 2, 3, 4, 5]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "nc", "max_span", "mean_span"]
        }
      },
      "value": [
        {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [72, 90, 102, 119, 101]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [10, 12, 12, 14, 13]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.5, 11.66666667, 10.5, 14, 12.5]
        }
      ]
    }

# Works with multiple grouping variables

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
          "value": ["id", "id1", "nc", "max_span", "mean_span"]
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
          "type": "integer",
          "attributes": {},
          "value": [72, 90, 102, 119, 101]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [10, 12, 12, 14, 13]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [9.5, 11.66666667, 10.5, 14, 12.5]
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
          "value": [1, 2, 3, 4, 5]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "nc", "max_span", "mean_span"]
        }
      },
      "value": [
        {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": ["NA", "NA", "NA", "NA", "NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [14, 10, 16, 14, 12]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [14, 9.33333333, 16.5, 14, 11.5]
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
          "value": [1, 2, 3, 4, 5]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "nc", "max_span", "mean_span"]
        }
      },
      "value": [
        {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [16, 15, 17, 17, 11]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [14, 10, 16, 14, 12]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [14, 9.33333333, 16.5, 14, 11.5]
        }
      ]
    }

