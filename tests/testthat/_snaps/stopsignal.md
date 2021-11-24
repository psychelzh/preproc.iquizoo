# Default behavior works

    Code
      preproc(data, stopsignal, .by = "id")
    Output
      # A tibble: 100 x 5
            id pc_all pc_go medrt_go  ssrt
         <int>  <dbl> <dbl>    <dbl> <dbl>
       1     1  0.519 0.517     777.  420.
       2     2  0.438 0.425     797.  338.
       3     3  0.525 0.483     804.  479.
       4     4  0.506 0.475     626.  282.
       5     5  0.525 0.533     610.  310.
       6     6  0.538 0.517     677.  336.
       7     7  0.512 0.55      658.  272.
       8     8  0.506 0.5       979.  682.
       9     9  0.419 0.442     728.  171.
      10    10  0.475 0.5       730.  204.
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, stopsignal, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 6
            id   id1 pc_all pc_go medrt_go  ssrt
         <int> <dbl>  <dbl> <dbl>    <dbl> <dbl>
       1     1     2  0.519 0.517     777.  420.
       2     2     3  0.438 0.425     797.  338.
       3     3     4  0.525 0.483     804.  479.
       4     4     5  0.506 0.475     626.  282.
       5     5     6  0.525 0.533     610.  310.
       6     6     7  0.538 0.517     677.  336.
       7     7     8  0.512 0.55      658.  272.
       8     8     9  0.506 0.5       979.  682.
       9     9    10  0.419 0.442     728.  171.
      10    10    11  0.475 0.5       730.  204.
      # ... with 90 more rows

