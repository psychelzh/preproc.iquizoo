# Test `nle()`: Number Line Estimation (junior version)

    Code
      nle(jsonlite::read_json("data/nle/sample_nlejr.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        mean_err mean_logerr mean_sqrterr is_normal
           <dbl>       <dbl>        <dbl> <lgl>    
      1    0.625       0.415        0.588 TRUE     

# Test `nle()`: Number Line Estimation (medium version)

    Code
      nle(jsonlite::read_json("data/nle/sample_nlemed.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        mean_err mean_logerr mean_sqrterr is_normal
           <dbl>       <dbl>        <dbl> <lgl>    
      1     4.32        1.32         1.71 TRUE     

# Test `nle()`: corrupted data

    Code
      nle(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        mean_err mean_logerr mean_sqrterr is_normal
        <lgl>    <lgl>       <lgl>        <lgl>    
      1 NA       NA          NA           FALSE    

---

    Code
      nle(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        mean_err mean_logerr mean_sqrterr is_normal
        <lgl>    <lgl>       <lgl>        <lgl>    
      1 NA       NA          NA           FALSE    

