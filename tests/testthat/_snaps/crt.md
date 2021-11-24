# Default behavior works

    Code
      preproc(data, crt, .by = "id")
    Output
      # A tibble: 100 x 4
            id   mrt  rtsd    nc
         <int> <dbl> <dbl> <int>
       1     1  749.  483.    19
       2     2 1054.  856.    38
       3     3  933.  622.    24
       4     4  924.  537.    36
       5     5  866.  694.    27
       6     6  931.  710.    23
       7     7  914.  731.    26
       8     8  990.  672.    35
       9     9  948.  562.    36
      10    10  861.  704.    30
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, crt, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 5
            id   id1   mrt  rtsd    nc
         <int> <dbl> <dbl> <dbl> <int>
       1     1     2  749.  483.    19
       2     2     3 1054.  856.    38
       3     3     4  933.  622.    24
       4     4     5  924.  537.    36
       5     5     6  866.  694.    27
       6     6     7  931.  710.    23
       7     7     8  914.  731.    26
       8     8     9  990.  672.    35
       9     9    10  948.  562.    36
      10    10    11  861.  704.    30
      # ... with 90 more rows

