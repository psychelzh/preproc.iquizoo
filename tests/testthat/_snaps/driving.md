# Default behavior works

    Code
      preproc(data, driving, .by = "id")
    Output
      # A tibble: 100 x 2
            id still_ratio
         <int>       <dbl>
       1     1       0.267
       2     2       0.153
       3     3       0.325
       4     4       0.168
       5     5       0.243
       6     6       0.275
       7     7       0.175
       8     8       0.304
       9     9       0.363
      10    10       0.216
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, driving, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 3
            id   id1 still_ratio
         <int> <dbl>       <dbl>
       1     1     2       0.267
       2     2     3       0.153
       3     3     4       0.325
       4     4     5       0.168
       5     5     6       0.243
       6     6     7       0.275
       7     7     8       0.175
       8     8     9       0.304
       9     9    10       0.363
      10    10    11       0.216
      # ... with 90 more rows

# No error for negative duration case (but produces `NA`s)

    Code
      preproc(data_negtive_dur, driving, .by = "id")
    Output
      # A tibble: 1 x 2
           id still_ratio
        <dbl>       <dbl>
      1     1          NA

