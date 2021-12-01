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
          "value": [1025.12018685]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1050.72008589]
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
          "value": [-25.59989904]
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
          "value": [1145.98131059, 1079.37361442, 1057.95448819, 1018.10626716, 854.95858122]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1001.84351284, 994.58091467, 983.95728312, 1101.49481704, 1059.68845325]
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
          "value": [144.13779775, 84.79269975, 73.99720507, -83.38854988, -204.72987203]
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
          "value": [994.96498335, 2193.30584558]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", "NA"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.75, 0.375]
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
          "value": [239.78148792, 871.11469454]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", 908.1417966]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.375, 0.25]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", 0]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", -37.02710206]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", -0.25]
        }
      ]
    }

