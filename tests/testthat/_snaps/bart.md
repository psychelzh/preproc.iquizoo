# Test `bart()`: Balloon Analogue Risk Task

    Code
      bart(jsonlite::read_json("data/bart/sample_bart.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        mean_pumps mean_pumps_raw num_explosion is_normal
             <dbl>          <dbl>         <int> <lgl>    
      1          5           5.23             3 TRUE     

# Test `bart()`: corrupted data

    Code
      bart(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        mean_pumps mean_pumps_raw num_explosion is_normal
             <dbl>          <dbl>         <dbl> <lgl>    
      1         NA             NA            NA FALSE    

---

    Code
      bart(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        mean_pumps mean_pumps_raw num_explosion is_normal
             <dbl>          <dbl>         <dbl> <lgl>    
      1         NA             NA            NA FALSE    

