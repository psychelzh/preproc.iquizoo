# Test `span()`: Backward Digit Span

    Code
      span(jsonlite::read_json("data/span/sample_bds.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        max_span mean_span    nc is_normal
           <int>     <dbl> <dbl> <lgl>    
      1        9      7.37    19 TRUE     

# Test `span()`: Forward Digit Span

    Code
      span(jsonlite::read_json("data/span/sample_fds.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        max_span mean_span    nc is_normal
           <int>     <dbl> <dbl> <lgl>    
      1       16      16.5   133 TRUE     

# Test `span()`: Forward Word Span

    Code
      span(jsonlite::read_json("data/span/sample_fws.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        max_span mean_span    nc is_normal
           <int>     <dbl> <dbl> <lgl>    
      1       16      16.5     0 TRUE     

# Test `span()`: Multiple Object Tracking

    Code
      span(jsonlite::read_json("data/span/sample_mot.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        max_span mean_span    nc is_normal
           <int>     <dbl> <dbl> <lgl>    
      1        8      6.83    57 TRUE     

# Test `span()`: Multiple Object Tracking (with distractors)

    Code
      span(jsonlite::read_json("data/span/sample_mot2.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        max_span mean_span    nc is_normal
           <int>     <dbl> <dbl> <lgl>    
      1        5      3.08    23 TRUE     

# Test `span()`: Symmetry Complex Span

    Code
      span(jsonlite::read_json("data/span/sample_sspan.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        max_span mean_span    nc is_normal
           <int>     <dbl> <dbl> <lgl>    
      1        7      5.17    49 TRUE     

# Test `span()`: Spatial Short-Term Memory

    Code
      span(jsonlite::read_json("data/span/sample_sstm.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        max_span mean_span    nc is_normal
           <int>     <dbl> <dbl> <lgl>    
      1        5      3.93    40 TRUE     

# Test `span()`: Spatial Short-term Memory (simple version)

    Code
      span(jsonlite::read_json("data/span/sample_sstms.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        max_span mean_span    nc is_normal
           <int>     <dbl> <dbl> <lgl>    
      1        8      6.23    73 TRUE     

# Test `span()`: corrupted data

    Code
      span(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        max_span mean_span nc    is_normal
        <lgl>    <lgl>     <lgl> <lgl>    
      1 NA       NA        NA    FALSE    

---

    Code
      span(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        max_span mean_span nc    is_normal
        <lgl>    <lgl>     <lgl> <lgl>    
      1 NA       NA        NA    FALSE    

