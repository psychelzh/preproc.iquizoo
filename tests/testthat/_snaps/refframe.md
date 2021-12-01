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
          "value": [1, 2, 3, 4, 5]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "mean_dist_err_both", "mean_dist_err_NA", "mean_log_err_both", "mean_log_err_NA"]
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
          "value": [101.91047849, 102.9245442, 102.56630821, 103.23325402, 101.25515534]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [101.91047849, 102.9245442, 102.56630821, 103.23325402, 101.25515534]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.37524342, 4.43191503, 4.47532532, 4.38499079, 4.41306199]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.37524342, 4.43191503, 4.47532532, 4.38499079, 4.41306199]
        }
      ]
    }

# Works with multiple grouping variables

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
          "value": ["id", "id1", "mean_dist_err_both", "mean_dist_err_NA", "mean_log_err_both", "mean_log_err_NA"]
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
          "value": [2, 3, 4, 5, 6]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [101.91047849, 102.9245442, 102.56630821, 103.23325402, 101.25515534]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [101.91047849, 102.9245442, 102.56630821, 103.23325402, 101.25515534]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.37524342, 4.43191503, 4.47532532, 4.38499079, 4.41306199]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [4.37524342, 4.43191503, 4.47532532, 4.38499079, 4.41306199]
        }
      ]
    }

