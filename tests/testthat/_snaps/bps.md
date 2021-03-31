# Default behavior works

    Code
      preproc_data(data, bps)
    Output
      # A tibble: 1,000 x 6
            id    pc p_sim_foil p_sim_lure p_sim_target bps_score
         <int> <dbl>      <dbl>      <dbl>        <dbl>     <dbl>
       1     1 0.283       0.3        0.4          0.25    0.1   
       2     2 0.367       0.2        0.45         0.45    0.25  
       3     3 0.333       0.3        0.2          0.35   -0.100 
       4     4 0.25        0.35       0.3          0.3    -0.0500
       5     5 0.25        0.5        0.35         0.25   -0.15  
       6     6 0.367       0.55       0.55         0.45    0     
       7     7 0.217       0.3        0.15         0.3    -0.15  
       8     8 0.267       0.3        0.25         0.25   -0.0500
       9     9 0.367       0.35       0.3          0.25   -0.0500
      10    10 0.3         0.4        0.2          0.45   -0.2   
      # ... with 990 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, bps, by = c("id", "id1"))
    Output
      # A tibble: 1,000 x 7
            id   id1    pc p_sim_foil p_sim_lure p_sim_target bps_score
         <int> <int> <dbl>      <dbl>      <dbl>        <dbl>     <dbl>
       1     1  1000 0.283       0.3        0.4          0.25    0.1   
       2     2   999 0.367       0.2        0.45         0.45    0.25  
       3     3   998 0.333       0.3        0.2          0.35   -0.100 
       4     4   997 0.25        0.35       0.3          0.3    -0.0500
       5     5   996 0.25        0.5        0.35         0.25   -0.15  
       6     6   995 0.367       0.55       0.55         0.45    0     
       7     7   994 0.217       0.3        0.15         0.3    -0.15  
       8     8   993 0.267       0.3        0.25         0.25   -0.0500
       9     9   992 0.367       0.35       0.3          0.25   -0.0500
      10    10   991 0.3         0.4        0.2          0.45   -0.2   
      # ... with 990 more rows

