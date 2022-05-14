# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc_approach", "pc_avoid", "pc_learn", "pc_test"]
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
          "value": [0.4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4]
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
          "value": ["id", "pc_approach", "pc_avoid", "pc_learn", "pc_test"]
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
          "value": [0.4, 0.6]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4, 0.7]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4, 0.65]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.4, 0.65]
        }
      ]
    }

