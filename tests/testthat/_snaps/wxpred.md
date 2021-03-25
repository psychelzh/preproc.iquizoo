# Test `wxpred()`: Weather Prediction Paradigm

    Code
      wxpred(jsonlite::read_json("data/wxpred/sample_wxpred.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 6
        pc_all pc_b1 pc_b2 pc_b3 pc_b4 is_normal
         <dbl> <dbl> <dbl> <dbl> <dbl> <lgl>    
      1   0.56  0.48  0.68  0.48   0.6 FALSE    

# Test `wxpred()`: Weather Prediction Paradigm (New version)

    Code
      wxpred(jsonlite::read_json("data/wxpred/sample_wxpred_new.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 6
        pc_all pc_b1 pc_b2 pc_b3 pc_b4 is_normal
         <dbl> <dbl> <dbl> <dbl> <dbl> <lgl>    
      1    0.5   0.5   0.4  0.45  0.65 FALSE    

# Test `wxpred()`: corrupted data

    Code
      wxpred(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 6
        pc_all pc_b1 pc_b2 pc_b3 pc_b4 is_normal
         <dbl> <dbl> <dbl> <dbl> <dbl> <lgl>    
      1     NA    NA    NA    NA    NA FALSE    

---

    Code
      wxpred(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 6
        pc_all pc_b1 pc_b2 pc_b3 pc_b4 is_normal
         <dbl> <dbl> <dbl> <dbl> <dbl> <lgl>    
      1     NA    NA    NA    NA    NA FALSE    

