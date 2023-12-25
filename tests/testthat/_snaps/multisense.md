# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["mrt_image", "mrt_sound", "mrt_mixed", "mrt_mixadv"]
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
          "value": [1.08932535]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.6914493]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.03335959]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.14297227]
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
          "value": ["id", "mrt_image", "mrt_sound", "mrt_mixed", "mrt_mixadv"]
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
          "value": [1.08932535, 1.35115456]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.6914493, 0.82471921]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.03335959, 0.88696221]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.14297227, 0.20097467]
        }
      ]
    }

