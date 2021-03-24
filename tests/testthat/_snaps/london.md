# Test `london()`: London Tower Test

    Code
      london(jsonlite::read_json("data/london/sample_london.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        total_score ratio_score mean_level is_normal
              <int>       <dbl>      <dbl> <lgl>    
      1        6490       0.469        6.9 TRUE     

# Test `london()`: London Tower Test (with no response trials)

    Code
      london(jsonlite::read_json("data/london/sample_london_no_resp.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        total_score ratio_score mean_level is_normal
              <int>       <dbl>      <dbl> <lgl>    
      1        1000           0       1.65 FALSE    

# Test `london()`: corrupted data

    Code
      london(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        total_score ratio_score mean_level is_normal
        <lgl>       <lgl>       <lgl>      <lgl>    
      1 NA          NA          NA         FALSE    

---

    Code
      london(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        total_score ratio_score mean_level is_normal
        <lgl>       <lgl>       <lgl>      <lgl>    
      1 NA          NA          NA         FALSE    

