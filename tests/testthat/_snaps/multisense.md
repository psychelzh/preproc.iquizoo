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
          "value": ["mrt_image", "mrt_mixed", "mrt_sound", "mrt_mixadv"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [891.52153593]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [923.4022274]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [874.95633315]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-40.16329286]
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
          "value": ["id", "mrt_image", "mrt_mixed", "mrt_sound", "mrt_mixadv"]
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
          "value": [913.81962092, 1167.90938812, 680.00838991, 637.13260971, 859.25544565]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [918.38962497, 886.96220644, 1357.60902653, 775.70710718, 657.40807826]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [691.44929584, 824.7192053, 1071.94434025, 792.62296531, 1150.98272239]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-115.75516659, 109.35209027, -481.63266145, -60.82931968, 347.71100576]
        }
      ]
    }

