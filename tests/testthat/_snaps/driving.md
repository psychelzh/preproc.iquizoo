# Test `driving()`: Driving Test (with 0 still durations)

    Code
      driving(jsonlite::read_json("data/driving/sample_driving.json", simplifyVector = TRUE))
    Output
        still_ratio is_normal
      1    0.514658      TRUE

# Test `driving()`: Driving Test

    Code
      driving(jsonlite::read_json("data/driving/sample_driving2.json",
        simplifyVector = TRUE))
    Output
        still_ratio is_normal
      1   0.4684123      TRUE

# Test `driving()`: corrupted data

    Code
      driving(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 2
        still_ratio is_normal
              <dbl> <lgl>    
      1          NA FALSE    

---

    Code
      driving(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 2
        still_ratio is_normal
              <dbl> <lgl>    
      1          NA FALSE    

