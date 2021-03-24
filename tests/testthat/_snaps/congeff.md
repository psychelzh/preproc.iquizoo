# Test `congeff()`: Flanker Paradigm

    Code
      congeff(jsonlite::read_json("data/congeff/sample_flanker.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 8
        mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc    nc is_normal
          <dbl>   <dbl>       <dbl>  <dbl>  <dbl>       <dbl> <int> <lgl>    
      1   1151.   1224.        73.3  0.971      1     -0.0294    65 TRUE     

# Test `congeff()`: Flanker Paradigm (temp version)

    Code
      congeff(jsonlite::read_json("data/congeff/sample_flanker2.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 8
        mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc    nc is_normal
          <dbl>   <dbl>       <dbl>  <dbl>  <dbl>       <dbl> <int> <lgl>    
      1    727.    751.        23.3      1  0.975       0.025    79 TRUE     

# Test `congeff()`: Stroop Paradigm

    Code
      congeff(jsonlite::read_json("data/congeff/sample_stroop.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 8
        mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc    nc is_normal
          <dbl>   <dbl>       <dbl>  <dbl>  <dbl>       <dbl> <int> <lgl>    
      1   1547.   2528.        981.  0.406  0.438     -0.0312    27 FALSE    

# Test `congeff()` on corrupted data

    Code
      congeff(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 8
        mrt_inc mrt_con cong_eff_rt pc_inc pc_con cong_eff_pc nc    is_normal
        <lgl>   <lgl>   <lgl>       <lgl>  <lgl>  <lgl>       <lgl> <lgl>    
      1 NA      NA      NA          NA     NA     NA          NA    FALSE    

---

    Code
      congeff(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 8
        mrt_inc mrt_con cong_eff_rt pc_inc pc_con cong_eff_pc nc    is_normal
        <lgl>   <lgl>   <lgl>       <lgl>  <lgl>  <lgl>       <lgl> <lgl>    
      1 NA      NA      NA          NA     NA     NA          NA    FALSE    

