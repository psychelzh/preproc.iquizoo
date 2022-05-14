# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["nc_loc", "mean_dist_err", "mean_log_err", "nc_order"]
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
          "type": "integer",
          "attributes": {},
          "value": [0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.98268293]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.66734896]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [19]
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
          "value": ["id", "nc_loc", "mean_dist_err", "mean_log_err", "nc_order"]
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
          "type": "integer",
          "attributes": {},
          "value": [0, 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.98268293, 5.2136]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.66734896, 1.69871346]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [19, 36]
        }
      ]
    }

