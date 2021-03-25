# Test `locmem()`: Location Memory

    Code
      locmem(jsonlite::read_json("data/locmem/sample_locmem.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
        mean_dist    pc is_normal
            <dbl> <dbl> <lgl>    
      1      3.13 0.269 TRUE     

# Test `locmem()`: Location Memory (junior version)

    Code
      locmem(jsonlite::read_json("data/locmem/sample_locmemjr.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
        mean_dist    pc is_normal
            <dbl> <dbl> <lgl>    
      1      0.89 0.667 TRUE     

# Test `locmem()`: Location Memory (medium version)

    Code
      locmem(jsonlite::read_json("data/locmem/sample_locmemmed.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
        mean_dist    pc is_normal
            <dbl> <dbl> <lgl>    
      1     0.704 0.690 TRUE     

# Test `locmem()`: corrupted data

    Code
      locmem(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 3
        mean_dist    pc is_normal
            <dbl> <dbl> <lgl>    
      1        NA    NA FALSE    

---

    Code
      locmem(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 3
        mean_dist    pc is_normal
            <dbl> <dbl> <lgl>    
      1        NA    NA FALSE    

