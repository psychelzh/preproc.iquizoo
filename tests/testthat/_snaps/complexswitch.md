# Default behavior works

    Code
      preproc(data, complexswitch, .by = "id")
    Output
      # A tibble: 100 x 17
            id mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc mrt_pure
         <int>   <dbl>   <dbl>       <dbl>  <dbl>  <dbl>       <dbl>    <dbl>
       1     1    850.    634.     -216.    0.455  0.383     0.0718      705.
       2     2    930.    936.        5.95  0.521  0.538    -0.0175     1152.
       3     3    961.    924.      -37.2   0.546  0.524     0.0226      799.
       4     4   1030.    979.      -50.6   0.517  0.492     0.0249     1036.
       5     5   1036.    972.      -64.5   0.451  0.590    -0.139       890.
       6     6    843.    874.       30.2   0.472  0.5      -0.0283      824.
       7     7    921.   1073.      151.    0.554  0.545     0.00990     894.
       8     8    888.   1078.      190.    0.441  0.487    -0.0463      965.
       9     9   1118.   1002.     -116.    0.423  0.510    -0.0869     1028.
      10    10    954.    984.       30.0   0.395  0.533    -0.139       857.
      # ... with 90 more rows, and 9 more variables: mrt_repeat <dbl>,
      #   mrt_switch <dbl>, switch_cost_rt_gen <dbl>, switch_cost_rt_spe <dbl>,
      #   pc_pure <dbl>, pc_repeat <dbl>, pc_switch <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

# All single condition

    Code
      preproc(data_miss_cond, complexswitch, .by = "id")
    Output
      # A tibble: 2 x 17
           id mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc mrt_pure
        <int>   <dbl>   <dbl>       <dbl>  <dbl>  <dbl>       <dbl>    <dbl>
      1     1      NA   1667.          NA     NA  0.625          NA    1939.
      2     2      NA    479.          NA     NA  0.625          NA     916.
      # ... with 9 more variables: mrt_repeat <dbl>, mrt_switch <dbl>,
      #   switch_cost_rt_gen <dbl>, switch_cost_rt_spe <dbl>, pc_pure <dbl>,
      #   pc_repeat <dbl>, pc_switch <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

# Part subject single condition

    Code
      preproc(data_part_miss_cond, complexswitch, .by = "id")
    Output
      # A tibble: 2 x 17
           id mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc mrt_pure
        <int>   <dbl>   <dbl>       <dbl>  <dbl>  <dbl>       <dbl>    <dbl>
      1     1     NA    1453.         NA      NA   0.5        NA       1099.
      2     2   1757.   1313.       -444.      1   0.75        0.25    1220.
      # ... with 9 more variables: mrt_repeat <dbl>, mrt_switch <dbl>,
      #   switch_cost_rt_gen <dbl>, switch_cost_rt_spe <dbl>, pc_pure <dbl>,
      #   pc_repeat <dbl>, pc_switch <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

# Works with multiple grouping variables

    Code
      preproc(data, complexswitch, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 18
            id   id1 mrt_con mrt_inc cong_eff_rt pc_con pc_inc cong_eff_pc mrt_pure
         <int> <dbl>   <dbl>   <dbl>       <dbl>  <dbl>  <dbl>       <dbl>    <dbl>
       1     1     2    850.    634.     -216.    0.455  0.383     0.0718      705.
       2     2     3    930.    936.        5.95  0.521  0.538    -0.0175     1152.
       3     3     4    961.    924.      -37.2   0.546  0.524     0.0226      799.
       4     4     5   1030.    979.      -50.6   0.517  0.492     0.0249     1036.
       5     5     6   1036.    972.      -64.5   0.451  0.590    -0.139       890.
       6     6     7    843.    874.       30.2   0.472  0.5      -0.0283      824.
       7     7     8    921.   1073.      151.    0.554  0.545     0.00990     894.
       8     8     9    888.   1078.      190.    0.441  0.487    -0.0463      965.
       9     9    10   1118.   1002.     -116.    0.423  0.510    -0.0869     1028.
      10    10    11    954.    984.       30.0   0.395  0.533    -0.139       857.
      # ... with 90 more rows, and 9 more variables: mrt_repeat <dbl>,
      #   mrt_switch <dbl>, switch_cost_rt_gen <dbl>, switch_cost_rt_spe <dbl>,
      #   pc_pure <dbl>, pc_repeat <dbl>, pc_switch <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

