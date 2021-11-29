# Default behavior works

    Code
      preproc(data, crt, .by = "id")
    Output
      # A tibble: 100 x 4
            id    nc   mrt  rtsd
         <int> <int> <dbl> <dbl>
       1     1    19  749.  483.
       2     2    38 1054.  856.
       3     3    24  933.  622.
       4     4    36  924.  537.
       5     5    27  866.  694.
       6     6    23  931.  710.
       7     7    26  914.  731.
       8     8    35  990.  672.
       9     9    36  948.  562.
      10    10    30  861.  704.
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, crt, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 5
            id   id1    nc   mrt  rtsd
         <int> <dbl> <int> <dbl> <dbl>
       1     1     2    19  749.  483.
       2     2     3    38 1054.  856.
       3     3     4    24  933.  622.
       4     4     5    36  924.  537.
       5     5     6    27  866.  694.
       6     6     7    23  931.  710.
       7     7     8    26  914.  731.
       8     8     9    35  990.  672.
       9     9    10    36  948.  562.
      10    10    11    30  861.  704.
      # ... with 90 more rows

