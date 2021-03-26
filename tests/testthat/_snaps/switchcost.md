# Test `switchcost()`: Card Sorting Test

    Code
      switchcost(jsonlite::read_json("data/switchcost/sample_cardsort.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 10
        rc_all rc_mixed rc_pure switch_cost_rc_gen mrt_pure mrt_repeat mrt_switch
         <dbl>    <dbl>   <dbl>              <dbl>    <dbl>      <dbl>      <dbl>
      1     20     19.5      21                1.5     694.       709.       798.
      # ... with 3 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, is_normal <lgl>

# Test `switchcost()`: Card Sorting Test (old version)

    Code
      switchcost(jsonlite::read_json("data/switchcost/sample_cardsort_old.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 10
        rc_all rc_mixed rc_pure switch_cost_rc_gen mrt_pure mrt_repeat mrt_switch
         <dbl>    <dbl>   <dbl>              <dbl>    <dbl>      <dbl>      <dbl>
      1     NA       NA      NA                 NA    1027.      1266.      1311.
      # ... with 3 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, is_normal <lgl>

# Test `switchcost()`: Card Sorting Test (5 blocks)

    Code
      switchcost(jsonlite::read_json("data/switchcost/sample_cardsort5.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 10
        rc_all rc_mixed rc_pure switch_cost_rc_gen mrt_pure mrt_repeat mrt_switch
         <dbl>    <dbl>   <dbl>              <dbl>    <dbl>      <dbl>      <dbl>
      1    9.4        9      10                  1    1009.      2173.      2845.
      # ... with 3 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, is_normal <lgl>

# Test `switchcost()`: Card Sorting Test (6 blocks)

    Code
      switchcost(jsonlite::read_json("data/switchcost/sample_cardsort6.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 10
        rc_all rc_mixed rc_pure switch_cost_rc_gen mrt_pure mrt_repeat mrt_switch
         <dbl>    <dbl>   <dbl>              <dbl>    <dbl>      <dbl>      <dbl>
      1     12     11.5      14                2.5     978.       1185      1260.
      # ... with 3 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, is_normal <lgl>

# Test `switchcost()`: Card Sorting Test (with invalid responses)

    Code
      switchcost(jsonlite::read_json("data/switchcost/sample_cardsort_issue.json",
        simplifyVector = TRUE))
    Warning <simpleWarning>
      At least one block has no response.
    Output
      # A tibble: 1 x 10
        rc_all rc_mixed rc_pure switch_cost_rc_gen mrt_pure mrt_repeat mrt_switch
         <dbl>    <dbl>   <dbl>              <dbl>    <dbl>      <dbl>      <dbl>
      1     NA       NA      NA                 NA       NA         NA         NA
      # ... with 3 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, is_normal <lgl>

# Test `switchcost()`: corrupted data

    Code
      switchcost(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 10
        rc_all rc_mixed rc_pure switch_cost_rc_gen mrt_pure mrt_repeat mrt_switch
         <dbl>    <dbl>   <dbl>              <dbl>    <dbl>      <dbl>      <dbl>
      1     NA       NA      NA                 NA       NA         NA         NA
      # ... with 3 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, is_normal <lgl>

---

    Code
      switchcost(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 10
        rc_all rc_mixed rc_pure switch_cost_rc_gen mrt_pure mrt_repeat mrt_switch
         <dbl>    <dbl>   <dbl>              <dbl>    <dbl>      <dbl>      <dbl>
      1     NA       NA      NA                 NA       NA         NA         NA
      # ... with 3 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, is_normal <lgl>

