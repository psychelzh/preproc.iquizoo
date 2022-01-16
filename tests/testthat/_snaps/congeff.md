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
          "value": ["mrt_inc", "mrt_con", "pc_inc", "pc_con", "cong_eff_rt", "cong_eff_pc"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {},
          "value": [1063.0624011]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1072.45463835]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5347432]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.49529781]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-9.39223725]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [-0.0394454]
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
          "value": ["id", "mrt_inc", "mrt_con", "pc_inc", "pc_con", "cong_eff_rt", "cong_eff_pc"]
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
          "value": [1226.98746039, 992.32762161, 1042.95156581, 1132.57618306, 899.1349509]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1020.54369226, 984.20536652, 921.4788, 1336.74102341, 1214.88897725]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.5, 0.57971014, 0.50819672, 0.58441558, 0.48333333]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51515152, 0.49180328, 0.50724638, 0.43396226, 0.51428571]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [206.44376813, 8.12225508, 121.47276581, -204.16484035, -315.75402635]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.01515152, -0.08790687, -0.00095034, -0.15045332, 0.03095238]
        }
      ]
    }

# All single condition

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
          "value": [1, 2]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "mrt_inc", "mrt_con", "pc_inc", "pc_con", "cong_eff_rt", "cong_eff_pc"]
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
          "value": [923.41088566, 859.07281813]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.51, 0.46]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA"]
        }
      ]
    }

# Part subject single condition

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
          "value": [1, 2]
        },
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["id", "mrt_inc", "mrt_con", "pc_inc", "pc_con", "cong_eff_rt", "cong_eff_pc"]
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
          "value": [1189.26308376, 796.93076249]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", 1274.99172009]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.48, 0.56]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", 0.5]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", -478.0609576]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", -0.06]
        }
      ]
    }

