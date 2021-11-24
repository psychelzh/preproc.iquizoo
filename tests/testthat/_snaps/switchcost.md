# Default behavior works

    Code
      preproc(data, switchcost, .by = "id")
    Output
      # A tibble: 100 x 11
            id mrt_pure mrt_repeat mrt_switch switch_cost_rt_gen switch_cost_rt_spe
         <int>    <dbl>      <dbl>      <dbl>              <dbl>              <dbl>
       1     1     903.       769.       802.            -134.                 32.6
       2     2    1055.       878.       979.            -178.                102. 
       3     3    1178.       742.       755.            -436.                 13.0
       4     4    1040.       959.       879.             -81.3               -80.0
       5     5     886.      1031.      1015.             145.                -16.3
       6     6     960.      1164.      1021.             203.               -142. 
       7     7    1018.      1017.       829.              -1.19             -188. 
       8     8     953.      1049.       930.              96.8              -119. 
       9     9     856.       966.       982.             110.                 16.4
      10    10    1101.      1063.       914.             -38.0              -149. 
      # ... with 90 more rows, and 5 more variables: pc_pure <dbl>, pc_repeat <dbl>,
      #   pc_switch <dbl>, switch_cost_pc_gen <dbl>, switch_cost_pc_spe <dbl>

# All single condition

    Code
      preproc(data_miss_cond, switchcost, .by = "id")
    Output
      # A tibble: 2 x 11
           id mrt_pure mrt_repeat mrt_switch switch_cost_rt_~ switch_cost_rt_~ pc_pure
        <int>    <dbl>      <dbl>      <dbl>            <dbl>            <dbl>   <dbl>
      1     1    1361.       260.        NaN          -1102.               NaN    0.75
      2     2    1118.      1075.        NaN            -43.0              NaN    0.5 
      # ... with 4 more variables: pc_repeat <dbl>, pc_switch <dbl>,
      #   switch_cost_pc_gen <dbl>, switch_cost_pc_spe <dbl>

# Part subject single condition

    Code
      preproc(data_part_miss_cond, switchcost, .by = "id")
    Output
      # A tibble: 2 x 11
           id mrt_pure mrt_repeat mrt_switch switch_cost_rt_~ switch_cost_rt_~ pc_pure
        <int>    <dbl>      <dbl>      <dbl>            <dbl>            <dbl>   <dbl>
      1     1    1309.       483.       NaN             -826.             NaN     0.5 
      2     2    1133.       457.      1731.            -676.            1274.    0.25
      # ... with 4 more variables: pc_repeat <dbl>, pc_switch <dbl>,
      #   switch_cost_pc_gen <dbl>, switch_cost_pc_spe <dbl>

# Works with multiple grouping variables

    Code
      preproc(data, switchcost, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 12
            id   id1 mrt_pure mrt_repeat mrt_switch switch_cost_rt_g~ switch_cost_rt_~
         <int> <dbl>    <dbl>      <dbl>      <dbl>             <dbl>            <dbl>
       1     1     2     903.       769.       802.           -134.               32.6
       2     2     3    1055.       878.       979.           -178.              102. 
       3     3     4    1178.       742.       755.           -436.               13.0
       4     4     5    1040.       959.       879.            -81.3             -80.0
       5     5     6     886.      1031.      1015.            145.              -16.3
       6     6     7     960.      1164.      1021.            203.             -142. 
       7     7     8    1018.      1017.       829.             -1.19           -188. 
       8     8     9     953.      1049.       930.             96.8            -119. 
       9     9    10     856.       966.       982.            110.               16.4
      10    10    11    1101.      1063.       914.            -38.0            -149. 
      # ... with 90 more rows, and 5 more variables: pc_pure <dbl>, pc_repeat <dbl>,
      #   pc_switch <dbl>, switch_cost_pc_gen <dbl>, switch_cost_pc_spe <dbl>

