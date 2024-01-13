# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["mean_dist_err_allo", "mean_dist_err_ego", "mean_dist_err_both", "mean_log_err_allo", "mean_log_err_ego", "mean_log_err_both"]
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
          "value": [103.18184027]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [100.63911672]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [101.91047849]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.42834597]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.32214087]
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
          "value": ["id", "mean_dist_err_allo", "mean_dist_err_ego", "mean_dist_err_both", "mean_log_err_allo", "mean_log_err_ego", "mean_log_err_both"]
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
          "value": [103.18184027, 115.04145214]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [100.63911672, 90.80763625]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [101.91047849, 102.9245442]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.42834597, 4.64390709]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.32214087, 4.21992297]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.37524342, 4.43191503]
        }
      ]
    }

