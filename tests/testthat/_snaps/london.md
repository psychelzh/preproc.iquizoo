# Default behavior works

    Code
      preproc(data, london, .by = "id")
    Output
      # A tibble: 100 x 4
            id total_score mean_level level_score
         <int>       <dbl>      <dbl>       <dbl>
       1     1        9044       7.5         2.20
       2     2       12026       7.67        2.29
       3     3       12178       6.83        1.96
       4     4       14717       8           2.16
       5     5       13086       7.5         2.00
       6     6        8085       6.67        2.20
       7     7       14511       8           2.48
       8     8       11227       6.5         1.45
       9     9       15148       8           2.16
      10    10       13433       7.83        2.94
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, london, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 5
            id   id1 total_score mean_level level_score
         <int> <dbl>       <dbl>      <dbl>       <dbl>
       1     1     2        9044       7.5         2.20
       2     2     3       12026       7.67        2.29
       3     3     4       12178       6.83        1.96
       4     4     5       14717       8           2.16
       5     5     6       13086       7.5         2.00
       6     6     7        8085       6.67        2.20
       7     7     8       14511       8           2.48
       8     8     9       11227       6.5         1.45
       9     9    10       15148       8           2.16
      10    10    11       13433       7.83        2.94
      # ... with 90 more rows

