# Default behavior works

    Code
      preproc(data, switchcost, .by = "id")
    Output
      # A tibble: 100 x 11
            id mrt_pure mrt_repeat mrt_switch pc_pure pc_repeat pc_switch
         <int>    <dbl>      <dbl>      <dbl>   <dbl>     <dbl>     <dbl>
       1     1     903.       769.       802.   0.540     0.556     0.4  
       2     2    1055.       878.       979.   0.516     0.485     0.589
       3     3    1178.       742.       755.   0.439     0.452     0.5  
       4     4    1040.       959.       879.   0.516     0.508     0.509
       5     5     886.      1031.      1015.   0.446     0.483     0.577
       6     6     960.      1164.      1021.   0.480     0.533     0.467
       7     7    1018.      1017.       829.   0.513     0.395     0.483
       8     8     953.      1049.       930.   0.507     0.5       0.421
       9     9     856.       966.       982.   0.530     0.45      0.422
      10    10    1101.      1063.       914.   0.568     0.492     0.579
      # ... with 90 more rows, and 4 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

# All single condition

    Code
      preproc(data_miss_cond, switchcost, .by = "id")
    Output
      # A tibble: 2 x 11
           id mrt_pure mrt_repeat mrt_switch pc_pure pc_repeat pc_switch
        <int>    <dbl>      <dbl>      <dbl>   <dbl>     <dbl>     <dbl>
      1     1    1361.       260.        NaN    0.75       0.5       NaN
      2     2    1118.      1075.        NaN    0.5        1         NaN
      # ... with 4 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

# Part subject single condition

    Code
      preproc(data_part_miss_cond, switchcost, .by = "id")
    Output
      # A tibble: 2 x 11
           id mrt_pure mrt_repeat mrt_switch pc_pure pc_repeat pc_switch
        <int>    <dbl>      <dbl>      <dbl>   <dbl>     <dbl>     <dbl>
      1     1    1309.       483.       NaN     0.5       0.75       NaN
      2     2    1133.       457.      1731.    0.25      0            1
      # ... with 4 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

# Works with multiple grouping variables

    Code
      preproc(data, switchcost, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 12
            id   id1 mrt_pure mrt_repeat mrt_switch pc_pure pc_repeat pc_switch
         <int> <dbl>    <dbl>      <dbl>      <dbl>   <dbl>     <dbl>     <dbl>
       1     1     2     903.       769.       802.   0.540     0.556     0.4  
       2     2     3    1055.       878.       979.   0.516     0.485     0.589
       3     3     4    1178.       742.       755.   0.439     0.452     0.5  
       4     4     5    1040.       959.       879.   0.516     0.508     0.509
       5     5     6     886.      1031.      1015.   0.446     0.483     0.577
       6     6     7     960.      1164.      1021.   0.480     0.533     0.467
       7     7     8    1018.      1017.       829.   0.513     0.395     0.483
       8     8     9     953.      1049.       930.   0.507     0.5       0.421
       9     9    10     856.       966.       982.   0.530     0.45      0.422
      10    10    11    1101.      1063.       914.   0.568     0.492     0.579
      # ... with 90 more rows, and 4 more variables: switch_cost_rt_gen <dbl>,
      #   switch_cost_rt_spe <dbl>, switch_cost_pc_gen <dbl>,
      #   switch_cost_pc_spe <dbl>

