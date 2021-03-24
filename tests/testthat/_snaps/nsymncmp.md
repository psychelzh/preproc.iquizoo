# Test `nsymncmp()`: Nonsymbolic Numeric Comparison

    Code
      nsymncmp(jsonlite::read_json("data/nsymncmp/sample_nsymncmp.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
           pc   mrt     w is_normal
        <dbl> <dbl> <dbl> <lgl>    
      1  0.75 1332. 0.350 TRUE     

# Test `nsymncmp()`: corrupted data

    Code
      nsymncmp(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        pc    mrt   w     is_normal
        <lgl> <lgl> <lgl> <lgl>    
      1 NA    NA    NA    FALSE    

---

    Code
      nsymncmp(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        pc    mrt   w     is_normal
        <lgl> <lgl> <lgl> <lgl>    
      1 NA    NA    NA    FALSE    

