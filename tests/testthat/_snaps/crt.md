# Test `crt()`: Choice Reaction Time

    Code
      crt(jsonlite::read_json("data/crt/sample_crt.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
          mrt    nc is_normal
        <dbl> <int> <lgl>    
      1  327.   334 TRUE     

# Test `crt()`: corrupted data

    Code
      crt(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 3
          mrt    nc is_normal
        <dbl> <dbl> <lgl>    
      1    NA    NA FALSE    

---

    Code
      crt(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 3
          mrt    nc is_normal
        <dbl> <dbl> <lgl>    
      1    NA    NA FALSE    

