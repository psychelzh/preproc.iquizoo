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
          "value": ["nc_loc", "mean_dist_err", "mean_log_err", "nc_order"]
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
          "value": [4.90858491]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.64232125]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [153]
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
          "value": ["id", "nc_loc", "mean_dist_err", "mean_log_err", "nc_order"]
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
          "value": [0, 0, 0, 0, 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [5.35707317, 5.05, 5.00854545, 4.24657534, 5.09554054]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.74100538, 1.67417627, 1.66380439, 1.50202915, 1.6777885]
        },
        {
          "type": "integer",
          "attributes": {},
          "value": [16, 33, 25, 36, 43]
        }
      ]
    }

