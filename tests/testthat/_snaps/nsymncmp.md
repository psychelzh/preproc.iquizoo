# Default behavior works

    Code
      preproc(data, nsymncmp, by = "id")
    Output
      # A tibble: 100 x 4
            id    pc   mrt     w
         <int> <dbl> <dbl> <dbl>
       1     1 0.525 1222. NA   
       2     2 0.5    964. NA   
       3     3 0.462 1096. NA   
       4     4 0.5    773.  9.09
       5     5 0.5   1015.  3.48
       6     6 0.45   813. NA   
       7     7 0.45   857. NA   
       8     8 0.512  781.  9.45
       9     9 0.562  745.  1.51
      10    10 0.45   766. NA   
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, nsymncmp, by = c("id", "id1"))
    Output
      # A tibble: 100 x 5
            id   id1    pc   mrt     w
         <int> <dbl> <dbl> <dbl> <dbl>
       1     1     2 0.525 1222. NA   
       2     2     3 0.5    964. NA   
       3     3     4 0.462 1096. NA   
       4     4     5 0.5    773.  9.09
       5     5     6 0.5   1015.  3.48
       6     6     7 0.45   813. NA   
       7     7     8 0.45   857. NA   
       8     8     9 0.512  781.  9.45
       9     9    10 0.562  745.  1.51
      10    10    11 0.45   766. NA   
      # ... with 90 more rows

