# Default behavior works

    Code
      preproc_data(data, nback, by = "id")
    Output
      # A tibble: 100 x 5
            id    pc   mrt dprime         c
         <int> <dbl> <dbl>  <dbl>     <dbl>
       1     1  0.4   966. -0.460 -5.55e-17
       2     2  0.5  1313.  0      2.30e- 1
       3     3  0.65  789.  0.703 -1.21e- 1
       4     4  0.6  1082.  0.473 -2.36e- 1
       5     5  0.5   971.  0      0       
       6     6  0.5   881.  0      2.30e- 1
       7     7  0.55 1474.  0.230  1.15e- 1
       8     8  0.4   669. -0.460 -5.55e-17
       9     9  0.45 1384. -0.243 -3.51e- 1
      10    10  0.55  411.  0.230  1.15e- 1
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, nback, by = c("id", "id1"))
    Output
      # A tibble: 100 x 6
            id   id1    pc   mrt dprime         c
         <int> <dbl> <dbl> <dbl>  <dbl>     <dbl>
       1     1     2  0.4   966. -0.460 -5.55e-17
       2     2     3  0.5  1313.  0      2.30e- 1
       3     3     4  0.65  789.  0.703 -1.21e- 1
       4     4     5  0.6  1082.  0.473 -2.36e- 1
       5     5     6  0.5   971.  0      0       
       6     6     7  0.5   881.  0      2.30e- 1
       7     7     8  0.55 1474.  0.230  1.15e- 1
       8     8     9  0.4   669. -0.460 -5.55e-17
       9     9    10  0.45 1384. -0.243 -3.51e- 1
      10    10    11  0.55  411.  0.230  1.15e- 1
      # ... with 90 more rows

