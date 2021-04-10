# Default behavior works

    Code
      preproc_data(data, sumweighted, by = "id")
    Output
      # A tibble: 100 x 2
            id nc_weighted
         <int>       <int>
       1     1          18
       2     2          19
       3     3          34
       4     4          37
       5     5          39
       6     6          30
       7     7          18
       8     8          18
       9     9          22
      10    10          38
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, sumweighted, by = c("id", "id1"))
    Output
      # A tibble: 100 x 3
            id   id1 nc_weighted
         <int> <dbl>       <int>
       1     1     2          18
       2     2     3          19
       3     3     4          34
       4     4     5          37
       5     5     6          39
       6     6     7          30
       7     7     8          18
       8     8     9          18
       9     9    10          22
      10    10    11          38
      # ... with 90 more rows

