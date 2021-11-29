# Default behavior works

    Code
      preproc(data, complexswitch, .by = "id")
    Output
      # A tibble: 100 x 17
            id mrt_inc mrt_con pc_inc pc_con cong_eff_rt cong_eff_pc mrt_pure
         <int>   <dbl>   <dbl>  <dbl>  <dbl>       <dbl>       <dbl>    <dbl>
       1     1    634.    850.  0.383  0.455     -216.       0.0718      705.
       2     2    936.    930.  0.538  0.521        5.95    -0.0175     1152.
       3     3    924.    961.  0.524  0.546      -37.2      0.0226      799.
       4     4    979.   1030.  0.492  0.517      -50.6      0.0249     1036.
       5     5    972.   1036.  0.590  0.451      -64.5     -0.139       890.
       6     6    874.    843.  0.5    0.472       30.2     -0.0283      824.
       7     7   1073.    921.  0.545  0.554      151.       0.00990     894.
       8     8   1078.    888.  0.487  0.441      190.      -0.0463      965.
       9     9   1002.   1118.  0.510  0.423     -116.      -0.0869     1028.
      10    10    984.    954.  0.533  0.395       30.0     -0.139       857.
      # ... with 90 more rows, and 9 more variables: mrt_repeat <dbl>,
      #   mrt_switch <dbl>, pc_pure <dbl>, pc_repeat <dbl>, pc_switch <dbl>,
      #   switch_cost_rt_gen <dbl>, switch_cost_rt_spe <dbl>,
      #   switch_cost_pc_gen <dbl>, switch_cost_pc_spe <dbl>

# All single condition

    Code
      preproc(data_miss_cond, complexswitch, .by = "id")
    Output
      # A tibble: 2 x 17
           id mrt_inc mrt_con pc_inc pc_con cong_eff_rt cong_eff_pc mrt_pure
        <int>   <dbl>   <dbl>  <dbl>  <dbl>       <dbl>       <dbl>    <dbl>
      1     1   1667.      NA  0.625     NA          NA          NA    1939.
      2     2    479.      NA  0.625     NA          NA          NA     916.
      # ... with 9 more variables: mrt_repeat <dbl>, mrt_switch <dbl>, pc_pure <dbl>,
      #   pc_repeat <dbl>, pc_switch <dbl>, switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

# Part subject single condition

    Code
      preproc(data_part_miss_cond, complexswitch, .by = "id")
    Output
      # A tibble: 2 x 17
           id mrt_inc mrt_con pc_inc pc_con cong_eff_rt cong_eff_pc mrt_pure
        <int>   <dbl>   <dbl>  <dbl>  <dbl>       <dbl>       <dbl>    <dbl>
      1     1   1453.     NA    0.5      NA         NA        NA       1099.
      2     2   1313.   1757.   0.75      1       -444.        0.25    1220.
      # ... with 9 more variables: mrt_repeat <dbl>, mrt_switch <dbl>, pc_pure <dbl>,
      #   pc_repeat <dbl>, pc_switch <dbl>, switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

# Works with multiple grouping variables

    Code
      preproc(data, complexswitch, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 18
            id   id1 mrt_inc mrt_con pc_inc pc_con cong_eff_rt cong_eff_pc mrt_pure
         <int> <dbl>   <dbl>   <dbl>  <dbl>  <dbl>       <dbl>       <dbl>    <dbl>
       1     1     2    634.    850.  0.383  0.455     -216.       0.0718      705.
       2     2     3    936.    930.  0.538  0.521        5.95    -0.0175     1152.
       3     3     4    924.    961.  0.524  0.546      -37.2      0.0226      799.
       4     4     5    979.   1030.  0.492  0.517      -50.6      0.0249     1036.
       5     5     6    972.   1036.  0.590  0.451      -64.5     -0.139       890.
       6     6     7    874.    843.  0.5    0.472       30.2     -0.0283      824.
       7     7     8   1073.    921.  0.545  0.554      151.       0.00990     894.
       8     8     9   1078.    888.  0.487  0.441      190.      -0.0463      965.
       9     9    10   1002.   1118.  0.510  0.423     -116.      -0.0869     1028.
      10    10    11    984.    954.  0.533  0.395       30.0     -0.139       857.
      # ... with 90 more rows, and 9 more variables: mrt_repeat <dbl>,
      #   mrt_switch <dbl>, pc_pure <dbl>, pc_repeat <dbl>, pc_switch <dbl>,
      #   switch_cost_rt_gen <dbl>, switch_cost_rt_spe <dbl>,
      #   switch_cost_pc_gen <dbl>, switch_cost_pc_spe <dbl>

