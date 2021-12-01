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
          "value": [803.75579222, 1493.40897739, 794.37215649, 669.36198297, 956.38643208]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [918.38962497, 979.59330603, 1357.60902653, 775.70710718, 729.48004185]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [767.10758437, 865.00646844, 1186.16791745, 753.27390864, 1283.47942599]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-132.95793668, 199.61441689, -367.33898956, -64.38916138, 390.45288719]
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
          "value": ["id", "id1", "mrt_image", "mrt_mixed", "mrt_sound", "mrt_mixadv"]
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
          "value": [803.75579222, 1493.40897739, 794.37215649, 669.36198297, 956.38643208]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [918.38962497, 979.59330603, 1357.60902653, 775.70710718, 729.48004185]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [767.10758437, 865.00646844, 1186.16791745, 753.27390864, 1283.47942599]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-132.95793668, 199.61441689, -367.33898956, -64.38916138, 390.45288719]
        }
      ]
    }

