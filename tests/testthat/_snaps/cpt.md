# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc", "mrt", "rtsd", "dprime", "commissions", "omissions"]
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
          "value": [1]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.34363152]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.47114892]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [3.36204386]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [0]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [0]
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
          "value": ["id", "pc", "mrt", "rtsd", "dprime", "commissions", "omissions"]
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
          "value": [1, 0.9]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.34363152, 1.53438086]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.47114892, 1.15924207]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [3.36204386, 2.16580127]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [0, 1]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [0, 1]
        }
      ]
    }

# Works on perfect accuracy data (no `NA`s)

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc", "mrt", "rtsd", "dprime", "commissions", "omissions"]
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
          "value": [1]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.43868832]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.75303022]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [3.36204386]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [0]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [0]
        }
      ]
    }

