# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["tm_dprime", "tm_bias", "fm_dprime", "fm_bias"]
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
          "value": [0.04988999]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.05815147]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.16619294]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [7.63278329e-17]
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
          "value": ["id", "tm_dprime", "tm_bias", "fm_dprime", "fm_bias"]
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
          "value": [0.16405893, -0.24337666, 0.60017878, -0.08257685, -0.16405893]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.16297676, 0.04074104, -0.30008939, 0.2037178, 0.16297676]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.75093988, -0.16189458, -0.16242937, 0.24337666, 0.16189458]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.13046372, 6.9388939e-17, 0.08121469, 0.04074104, 6.9388939e-17]
        }
      ]
    }

