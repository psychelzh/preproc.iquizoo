# Test `complexswitch()`: Birds Migration

    Code
      complexswitch(jsonlite::read_json("data/complexswitch/sample_birds.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 16
        mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc rc_all rc_mixed rc_pure
          <dbl>   <dbl>       <dbl>  <dbl>  <dbl>       <dbl>  <dbl>    <dbl>   <dbl>
      1    641.    789.        148.  0.856  0.752       0.105     41     30.8    61.5
      # ... with 7 more variables: switch_cost_rc_gen <dbl>, mrt_pure <dbl>,
      #   mrt_repeat <dbl>, mrt_switch <dbl>, switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, is_normal <lgl>

# Test `complexswitch()`: Faces

    Code
      complexswitch(jsonlite::read_json("data/complexswitch/sample_faces.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 16
        mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc rc_all rc_mixed rc_pure
          <dbl>   <dbl>       <dbl>  <dbl>  <dbl>       <dbl>  <dbl>    <dbl>   <dbl>
      1   1109.   1288.        178.  0.792  0.842     -0.0497     15       15      15
      # ... with 7 more variables: switch_cost_rc_gen <dbl>, mrt_pure <dbl>,
      #   mrt_repeat <dbl>, mrt_switch <dbl>, switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, is_normal <lgl>

# Test `complexswitch()`: Faces (invalid response data)

    Code
      complexswitch(jsonlite::read_json("data/complexswitch/sample_faces_issue.json",
        simplifyVector = TRUE))
    Warning <simpleWarning>
      At least one block has no response.
    Output
      # A tibble: 1 x 16
        mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc rc_all rc_mixed rc_pure
        <lgl>   <lgl>   <lgl>       <lgl>  <lgl>  <lgl>       <lgl>  <lgl>    <lgl>  
      1 NA      NA      NA          NA     NA     NA          NA     NA       NA     
      # ... with 7 more variables: switch_cost_rc_gen <lgl>, mrt_pure <lgl>,
      #   mrt_repeat <lgl>, mrt_switch <lgl>, switch_cost_rt_gen <lgl>,
      #   switch_cost_rt_spe <lgl>, is_normal <lgl>

# Test `complexswitch()`: corrupted data

    Code
      complexswitch(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 16
        mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc rc_all rc_mixed rc_pure
        <lgl>   <lgl>   <lgl>       <lgl>  <lgl>  <lgl>       <lgl>  <lgl>    <lgl>  
      1 NA      NA      NA          NA     NA     NA          NA     NA       NA     
      # ... with 7 more variables: switch_cost_rc_gen <lgl>, mrt_pure <lgl>,
      #   mrt_repeat <lgl>, mrt_switch <lgl>, switch_cost_rt_gen <lgl>,
      #   switch_cost_rt_spe <lgl>, is_normal <lgl>

---

    Code
      complexswitch(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 16
        mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc rc_all rc_mixed rc_pure
        <lgl>   <lgl>   <lgl>       <lgl>  <lgl>  <lgl>       <lgl>  <lgl>    <lgl>  
      1 NA      NA      NA          NA     NA     NA          NA     NA       NA     
      # ... with 7 more variables: switch_cost_rc_gen <lgl>, mrt_pure <lgl>,
      #   mrt_repeat <lgl>, mrt_switch <lgl>, switch_cost_rt_gen <lgl>,
      #   switch_cost_rt_spe <lgl>, is_normal <lgl>

