# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["tm_dprime", "tm_bias", "fm_dprime", "fm_bias", "memory_score"]
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
          "value": [0.16405893]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.16297676]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.75093988]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.13046372]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.58688094]
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
          "value": ["id", "tm_dprime", "tm_bias", "fm_dprime", "fm_bias", "memory_score"]
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
          "value": [0.16405893, -0.24337666]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.16297676, 0.04074104]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.75093988, -0.16189458]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.13046372, 6.9388939e-17]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.58688094, -0.08148208]
        }
      ]
    }

