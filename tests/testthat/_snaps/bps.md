# Default behavior works

    Code
      preproc_data(data, bps)
    Output
      # A tibble: 1,000 x 7
            id    pc p_sim_foil p_sim_lure p_sim_target bps_score is_normal
         <int> <dbl>      <dbl>      <dbl>        <dbl>     <dbl> <lgl>    
       1     1 0.35        0.3        0.4          0.25    0.1    FALSE    
       2     2 0.383       0.2        0.45         0.45    0.25   FALSE    
       3     3 0.367       0.3        0.2          0.35   -0.100  FALSE    
       4     4 0.267       0.35       0.3          0.3    -0.0500 FALSE    
       5     5 0.267       0.5        0.35         0.25   -0.15   FALSE    
       6     6 0.383       0.55       0.55         0.45    0      FALSE    
       7     7 0.25        0.3        0.15         0.3    -0.15   FALSE    
       8     8 0.283       0.3        0.25         0.25   -0.0500 FALSE    
       9     9 0.383       0.35       0.3          0.25   -0.0500 FALSE    
      10    10 0.317       0.4        0.2          0.45   -0.2    FALSE    
      # ... with 990 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, bps, by = c("id", "id1"))
    Output
      # A tibble: 1,000 x 8
            id   id1    pc p_sim_foil p_sim_lure p_sim_target bps_score is_normal
         <int> <int> <dbl>      <dbl>      <dbl>        <dbl>     <dbl> <lgl>    
       1     1  1000 0.35        0.3        0.4          0.25    0.1    FALSE    
       2     2   999 0.383       0.2        0.45         0.45    0.25   FALSE    
       3     3   998 0.367       0.3        0.2          0.35   -0.100  FALSE    
       4     4   997 0.267       0.35       0.3          0.3    -0.0500 FALSE    
       5     5   996 0.267       0.5        0.35         0.25   -0.15   FALSE    
       6     6   995 0.383       0.55       0.55         0.45    0      FALSE    
       7     7   994 0.25        0.3        0.15         0.3    -0.15   FALSE    
       8     8   993 0.283       0.3        0.25         0.25   -0.0500 FALSE    
       9     9   992 0.383       0.35       0.3          0.25   -0.0500 FALSE    
      10    10   991 0.317       0.4        0.2          0.45   -0.2    FALSE    
      # ... with 990 more rows

