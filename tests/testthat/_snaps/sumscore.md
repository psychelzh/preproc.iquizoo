# Default behavior works

    Code
      preproc(data, sumscore, .by = "id")
    Output
      # A tibble: 100 x 2
            id nc_score
         <int>    <dbl>
       1     1       57
       2     2       53
       3     3       63
       4     4       56
       5     5       66
       6     6       53
       7     7       52
       8     8       63
       9     9       66
      10    10       56
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, sumscore, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 3
            id   id1 nc_score
         <int> <dbl>    <dbl>
       1     1     2       57
       2     2     3       53
       3     3     4       63
       4     4     5       56
       5     5     6       66
       6     6     7       53
       7     7     8       52
       8     8     9       63
       9     9    10       66
      10    10    11       56
      # ... with 90 more rows

