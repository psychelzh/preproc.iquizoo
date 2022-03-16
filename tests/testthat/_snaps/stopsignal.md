# Default behavior works

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["rt_nth", "ssrt", "pc_all", "pc_go", "pc_stop"]
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
          "value": [569.17946129]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [227.86001685]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51875]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51666667]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.525]
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
          "value": ["id", "rt_nth", "ssrt", "pc_all", "pc_go", "pc_stop"]
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
          "value": [569.17946129, 711.4702006, 194.86471319, 452.37713861, 552.19243537]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [227.86001685, 252.37929151, -114.06385824, 110.38995912, 251.83529251]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51875, 0.4375, 0.525, 0.50625, 0.525]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51666667, 0.425, 0.48333333, 0.475, 0.53333333]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.525, 0.475, 0.65, 0.6, 0.5]
        }
      ]
    }

