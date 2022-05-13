# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["pc_all", "pc_go", "pc_stop", "rt_nth", "mean_ssd", "ssrt"]
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
          "value": [0.7]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.71666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.65]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [296.36795739]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [308.92857143]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-12.56061404]
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
          "value": ["id", "pc_all", "pc_go", "pc_stop", "rt_nth", "mean_ssd", "ssrt"]
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
          "value": [0.7, 0.6625]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.71666667, 0.68333333]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.65, 0.6]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [296.36795739, 400.94416334]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [308.92857143, 341.98717949]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-12.56061404, 58.95698386]
        }
      ]
    }

