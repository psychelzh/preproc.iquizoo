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
          "value": ["mean_dist_err_both", "mean_dist_err_NA", "mean_log_err_both", "mean_log_err_NA"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [101.91047849]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [101.91047849]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.37524342]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.37524342]
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
          "value": ["id", "mean_dist_err_both", "mean_dist_err_NA", "mean_log_err_both", "mean_log_err_NA"]
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
          "value": [101.91047849, 102.9245442]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [101.91047849, 102.9245442]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.37524342, 4.43191503]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.37524342, 4.43191503]
        }
      ]
    }

