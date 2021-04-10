# Default behavior works

    Code
      preproc_data(data, countcorrect2, by = "id")
    Output
      # A tibble: 100 x 2
            id nc_cor
         <int>  <int>
       1     1     13
       2     2     -2
       3     3     40
       4     4    -14
       5     5     33
       6     6     69
       7     7     81
       8     8     45
       9     9    102
      10    10    139
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, countcorrect2, by = c("id", "id1"))
    Output
      # A tibble: 100 x 3
            id   id1 nc_cor
         <int> <dbl>  <int>
       1     1     2     13
       2     2     3     -2
       3     3     4     40
       4     4     5    -14
       5     5     6     33
       6     6     7     69
       7     7     8     81
       8     8     9     45
       9     9    10    102
      10    10    11    139
      # ... with 90 more rows

