# Test `srt()`: Simple Reaction Time

    Code
      srt(jsonlite::read_json("data/srt/sample_srt.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
        percent_valid   mrt is_normal
                <dbl> <dbl> <lgl>    
      1           0.9  150. TRUE     

# Test `srt()`: Simple Reaction Time (abnormal response)

    Code
      srt(jsonlite::read_json("data/srt/sample_srt_abnormal.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
        percent_valid   mrt is_normal
                <dbl> <dbl> <lgl>    
      1         0.125  318. FALSE    

# Test `srt()`: corrupted data

    Code
      srt(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 3
        percent_valid mrt   is_normal
        <lgl>         <lgl> <lgl>    
      1 NA            NA    FALSE    

---

    Code
      srt(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 3
        percent_valid mrt   is_normal
        <lgl>         <lgl> <lgl>    
      1 NA            NA    FALSE    

