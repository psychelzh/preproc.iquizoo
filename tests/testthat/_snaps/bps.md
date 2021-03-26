# Test `bps()`: Behavioral Pattern Separation

    Code
      bps(jsonlite::read_json("data/bps/sample_bps.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 6
           pc p_sim_lure p_sim_foil p_sim_old bps_score is_normal
        <dbl>      <dbl>      <dbl>     <dbl>     <dbl> <lgl>    
      1 0.592      0.425      0.175       0.1      0.25 TRUE     

# Test `bps()`: corrupted data

    Code
      bps(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 6
           pc p_sim_lure p_sim_foil p_sim_old bps_score is_normal
        <dbl>      <dbl>      <dbl>     <dbl>     <dbl> <lgl>    
      1    NA         NA         NA        NA        NA FALSE    

---

    Code
      bps(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 6
           pc p_sim_lure p_sim_foil p_sim_old bps_score is_normal
        <dbl>      <dbl>      <dbl>     <dbl>     <dbl> <lgl>    
      1    NA         NA         NA        NA        NA FALSE    

