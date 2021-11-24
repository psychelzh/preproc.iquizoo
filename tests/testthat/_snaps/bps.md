# Default behavior works

    Code
      preproc(data, bps, .by = "id")
    Output
      # A tibble: 1,000 x 6
            id    pc p_sim_foil p_sim_lure p_sim_target bps_score
         <int> <dbl>      <dbl>      <dbl>        <dbl>     <dbl>
       1     1 0.35        0.3        0.4          0.25      0.1 
       2     2 0.383       0.2        0.45         0.45      0.25
       3     3 0.367       0.3        0.2          0.35     -0.1 
       4     4 0.267       0.35       0.3          0.3      -0.05
       5     5 0.267       0.5        0.35         0.25     -0.15
       6     6 0.383       0.55       0.55         0.45      0   
       7     7 0.25        0.3        0.15         0.3      -0.15
       8     8 0.283       0.3        0.25         0.25     -0.05
       9     9 0.383       0.35       0.3          0.25     -0.05
      10    10 0.317       0.4        0.2          0.45     -0.2 
      # ... with 990 more rows

# Works with multiple grouping variables

    Code
      preproc(data, bps, .by = c("id", "id1"))
    Output
      # A tibble: 1,000 x 7
            id   id1    pc p_sim_foil p_sim_lure p_sim_target bps_score
         <int> <dbl> <dbl>      <dbl>      <dbl>        <dbl>     <dbl>
       1     1     2 0.35        0.3        0.4          0.25      0.1 
       2     2     3 0.383       0.2        0.45         0.45      0.25
       3     3     4 0.367       0.3        0.2          0.35     -0.1 
       4     4     5 0.267       0.35       0.3          0.3      -0.05
       5     5     6 0.267       0.5        0.35         0.25     -0.15
       6     6     7 0.383       0.55       0.55         0.45      0   
       7     7     8 0.25        0.3        0.15         0.3      -0.15
       8     8     9 0.283       0.3        0.25         0.25     -0.05
       9     9    10 0.383       0.35       0.3          0.25     -0.05
      10    10    11 0.317       0.4        0.2          0.45     -0.2 
      # ... with 990 more rows

