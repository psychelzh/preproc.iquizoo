# Test `nback()`: One Back Test

    Code
      nback(jsonlite::read_json("data/nback/sample_nback1.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 5
           pc   mrt dprime      c is_normal
        <dbl> <dbl>  <dbl>  <dbl> <lgl>    
      1 0.875  560.   2.21 0.0623 TRUE     

# Test `nback()`: Two Back Test

    Code
      nback(jsonlite::read_json("data/nback/sample_nback2.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 5
           pc   mrt dprime      c is_normal
        <dbl> <dbl>  <dbl>  <dbl> <lgl>    
      1 0.625   280  0.629 -0.179 FALSE    

# Test `nback()`: Three Back Test

    Code
      nback(jsonlite::read_json("data/nback/sample_nback3.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 5
           pc   mrt dprime      c is_normal
        <dbl> <dbl>  <dbl>  <dbl> <lgl>    
      1  0.75  623.   1.33 -0.169 TRUE     

# Test `nback()`: Four Back Test

    Code
      nback(jsonlite::read_json("data/nback/sample_nback4.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 5
           pc   mrt dprime      c is_normal
        <dbl> <dbl>  <dbl>  <dbl> <lgl>    
      1 0.681  881.  0.917 -0.113 TRUE     

# Test `nback()` on corrupted data

    Code
      nback(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 5
           pc   mrt dprime     c is_normal
        <dbl> <dbl>  <dbl> <dbl> <lgl>    
      1    NA    NA     NA    NA FALSE    

---

    Code
      nback(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 5
           pc   mrt dprime     c is_normal
        <dbl> <dbl>  <dbl> <dbl> <lgl>    
      1    NA    NA     NA    NA FALSE    

