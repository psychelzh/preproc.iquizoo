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
          "value": [992.19552198]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [979.72765499]
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
          "value": [12.467867]
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
          "value": [1153.24609604, 874.35675531, 1008.55062922, 1055.63127084, 868.79320251]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [961.07565385, 887.97684039, 847.20724981, 1278.49485469, 1050.09855281]
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
          "value": [192.17044219, -13.62008508, 161.34337941, -222.86358385, -181.30535029]
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
          "value": [871.38259604, 700.08853136]
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
          "value": [1025.09479917, 665.89313992]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", 1129.55908988]
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
          "value": ["NA", -463.66594997]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", -0.06]
        }
      ]
    }

