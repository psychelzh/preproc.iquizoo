# Test `symncmp()`: Symbolic Numeric Comparison

    Code
      symncmp(jsonlite::read_json("data/symncmp/sample_symncmp.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 5
           pc   mrt dist_eff dist_eff_adj is_normal
        <dbl> <dbl>    <dbl>        <dbl> <lgl>    
      1 0.931  564.     5.80       0.0103 TRUE     

# Test `symncmp()`: corrupted data

    Code
      symncmp(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 5
           pc   mrt dist_eff dist_eff_adj is_normal
        <dbl> <dbl>    <dbl>        <dbl> <lgl>    
      1    NA    NA       NA           NA FALSE    

---

    Code
      symncmp(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 5
           pc   mrt dist_eff dist_eff_adj is_normal
        <dbl> <dbl>    <dbl>        <dbl> <lgl>    
      1    NA    NA       NA           NA FALSE    

