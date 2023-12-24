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
          "value": [0.91381962]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.6914493]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.91838962]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.11575517]
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
          "value": [0.91381962, 1.16790939]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.6914493, 0.82471921]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.91838962, 0.88696221]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.11575517, 0.10935209]
        }
      ]
    }

