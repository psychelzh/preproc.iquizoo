# Default behavior works

    Code
      preproc_data(data, nback)
    Output
      # A tibble: 100 x 5
            id    pc   mrt dprime       c
         <int> <dbl> <dbl>  <dbl>   <dbl>
       1     1 0.4   1381. -0.482  0     
       2     2 0.65  1151.  0.732  0     
       3     3 0.475  751. -0.120  0.0598
       4     4 0.525 1214.  0.120  0.0598
       5     5 0.4   1126. -0.482  0     
       6     6 0.525 1580.  0.121  0.180 
       7     7 0.5   1011.  0      0.120 
       8     8 0.5    702.  0     -0.637 
       9     9 0.575  748.  0.361 -0.0607
      10    10 0.425  972. -0.361 -0.0607
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, nback, by = c("id", "id1"))
    Output
      # A tibble: 100 x 6
            id   id1    pc   mrt dprime       c
         <int> <dbl> <dbl> <dbl>  <dbl>   <dbl>
       1     1     2 0.4   1381. -0.482  0     
       2     2     3 0.65  1151.  0.732  0     
       3     3     4 0.475  751. -0.120  0.0598
       4     4     5 0.525 1214.  0.120  0.0598
       5     5     6 0.4   1126. -0.482  0     
       6     6     7 0.525 1580.  0.121  0.180 
       7     7     8 0.5   1011.  0      0.120 
       8     8     9 0.5    702.  0     -0.637 
       9     9    10 0.575  748.  0.361 -0.0607
      10    10    11 0.425  972. -0.361 -0.0607
      # ... with 90 more rows

