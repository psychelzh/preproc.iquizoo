# Default behavior works

    Code
      preproc_data(data, cpt)
    Output
      # A tibble: 100 x 10
            id    pc   mrt  rtsd  dprime         c  hits commissions omissions    ne
         <int> <dbl> <dbl> <dbl>   <dbl>     <dbl> <int>       <int>     <int> <int>
       1     1 0.48  1012.  946. -0.146   0.0457      33         116        40   156
       2     2 0.487 1055.  967. -0.0660 -0.000434    37         115        39   154
       3     3 0.483 1089. 1125. -0.0874  0.00452     37         115        40   155
       4     4 0.563 1069.  912.  0.346  -0.0289      43         100        31   131
       5     5 0.507  946.  745. -0.0335  0.0740      38         104        44   148
       6     6 0.533 1439. 1225.  0.0682  0.0894      32         105        35   140
       7     7 0.517 1132.  929.  0.194  -0.114       45         113        32   145
       8     8 0.533 1129. 1075.  0.183  -0.0182      43         104        36   140
       9     9 0.443 1286. 1236. -0.291   0.00758     32         126        41   167
      10    10 0.457 1242. 1081. -0.209  -0.00691     35         122        41   163
      # ... with 90 more rows

# Works on perfect accuracy data (no `NA`s)

    Code
      preproc_data(data_perfect, cpt)
    Output
      # A tibble: 1 x 10
           id    pc   mrt  rtsd dprime     c  hits commissions omissions    ne
        <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <int>       <int>     <int> <int>
      1     1     1  810.  849.   2.56 0.313     2           0         0     0

# Works with multiple grouping variables

    Code
      preproc_data(data, cpt, by = c("id", "id1"))
    Output
      # A tibble: 100 x 11
            id   id1    pc   mrt  rtsd  dprime         c  hits commissions omissions
         <int> <dbl> <dbl> <dbl> <dbl>   <dbl>     <dbl> <int>       <int>     <int>
       1     1     2 0.48  1012.  946. -0.146   0.0457      33         116        40
       2     2     3 0.487 1055.  967. -0.0660 -0.000434    37         115        39
       3     3     4 0.483 1089. 1125. -0.0874  0.00452     37         115        40
       4     4     5 0.563 1069.  912.  0.346  -0.0289      43         100        31
       5     5     6 0.507  946.  745. -0.0335  0.0740      38         104        44
       6     6     7 0.533 1439. 1225.  0.0682  0.0894      32         105        35
       7     7     8 0.517 1132.  929.  0.194  -0.114       45         113        32
       8     8     9 0.533 1129. 1075.  0.183  -0.0182      43         104        36
       9     9    10 0.443 1286. 1236. -0.291   0.00758     32         126        41
      10    10    11 0.457 1242. 1081. -0.209  -0.00691     35         122        41
      # ... with 90 more rows, and 1 more variable: ne <int>

