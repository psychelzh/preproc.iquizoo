# Default behavior works

    Code
      preproc(data, srt, by = "id")
    Output
      # A tibble: 100 x 3
            id   mrt  rtsd
         <int> <dbl> <dbl>
       1     1  934.  693.
       2     2 1042.  706.
       3     3  748.  462.
       4     4 1112.  908.
       5     5  856.  601.
       6     6  849.  681.
       7     7  820.  533.
       8     8 1114.  802.
       9     9  845.  600.
      10    10  921.  664.
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, srt, by = c("id", "id1"))
    Output
      # A tibble: 100 x 4
            id   id1   mrt  rtsd
         <int> <dbl> <dbl> <dbl>
       1     1     2  934.  693.
       2     2     3 1042.  706.
       3     3     4  748.  462.
       4     4     5 1112.  908.
       5     5     6  856.  601.
       6     6     7  849.  681.
       7     7     8  820.  533.
       8     8     9 1114.  802.
       9     9    10  845.  600.
      10    10    11  921.  664.
      # ... with 90 more rows

