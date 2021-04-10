# Default behavior works

    Code
      preproc_data(data, symncmp, by = "id")
    Output
      # A tibble: 100 x 4
            id    pc   mrt dist_eff
         <int> <dbl> <dbl>    <dbl>
       1     1 0.542 1113.     19.7
       2     2 0.472  883.    -68.5
       3     3 0.444  793.    -45.4
       4     4 0.569  969.    -53.5
       5     5 0.5   1258.     35.9
       6     6 0.389  986.    -84.4
       7     7 0.472 1235.    284. 
       8     8 0.486  954.    209. 
       9     9 0.528  951.     73.0
      10    10 0.556 1094.   -105. 
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, symncmp, by = c("id", "id1"))
    Output
      # A tibble: 100 x 5
            id   id1    pc   mrt dist_eff
         <int> <dbl> <dbl> <dbl>    <dbl>
       1     1     2 0.542 1113.     19.7
       2     2     3 0.472  883.    -68.5
       3     3     4 0.444  793.    -45.4
       4     4     5 0.569  969.    -53.5
       5     5     6 0.5   1258.     35.9
       6     6     7 0.389  986.    -84.4
       7     7     8 0.472 1235.    284. 
       8     8     9 0.486  954.    209. 
       9     9    10 0.528  951.     73.0
      10    10    11 0.556 1094.   -105. 
      # ... with 90 more rows

