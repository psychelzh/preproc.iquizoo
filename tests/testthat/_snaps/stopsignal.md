# Test `stopsignal()`: Stop Signal Task

    Code
      stopsignal(jsonlite::read_json("data/stopsignal/sample_stopsignal.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 6
        pc_all pc_go medrt_go mean_ssd  ssrt is_normal
         <dbl> <dbl>    <int>    <dbl> <dbl> <lgl>    
      1  0.312   0.3      533     263.  270. FALSE    

# Test `stopsignal()`: corrupted data

    Code
      stopsignal(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 6
        pc_all pc_go medrt_go mean_ssd  ssrt is_normal
         <dbl> <dbl>    <dbl>    <dbl> <dbl> <lgl>    
      1     NA    NA       NA       NA    NA FALSE    

---

    Code
      stopsignal(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 6
        pc_all pc_go medrt_go mean_ssd  ssrt is_normal
         <dbl> <dbl>    <dbl>    <dbl> <dbl> <lgl>    
      1     NA    NA       NA       NA    NA FALSE    

