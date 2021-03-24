# Test `jlo()`: Judgment of Line Orientation

    Code
      jlo(jsonlite::read_json("data/jlo/sample_jlo.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 5
           nc    ne ne_ln ne_sqrt is_normal
        <int> <dbl> <dbl>   <dbl> <lgl>    
      1    13   174  42.0    55.5 TRUE     

# Test `jlo()`: corrupted data

    Code
      jlo(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 5
        nc    ne    ne_ln ne_sqrt is_normal
        <lgl> <lgl> <lgl> <lgl>   <lgl>    
      1 NA    NA    NA    NA      FALSE    

---

    Code
      jlo(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 5
        nc    ne    ne_ln ne_sqrt is_normal
        <lgl> <lgl> <lgl> <lgl>   <lgl>    
      1 NA    NA    NA    NA      FALSE    

