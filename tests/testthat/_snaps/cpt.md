# Default behavior works

    Code
      preproc_data(data, cpt)
    Output
      # A tibble: 100 x 8
            id    nc   mrt  rtsd  dprime         c commissions omissions
         <int> <int> <dbl> <dbl>   <dbl>     <dbl>       <int>     <int>
       1     1   144  919.  788. -0.146   0.0457           116        40
       2     2   146  814.  475. -0.0660 -0.000434         115        39
       3     3   145  758.  478. -0.0874  0.00452          115        40
       4     4   169  996.  819.  0.346  -0.0289           100        31
       5     5   152  946.  745. -0.0335  0.0740           104        44
       6     6   160 1312. 1015.  0.0682  0.0894           105        35
       7     7   155  939.  634.  0.194  -0.114            113        32
       8     8   160  827.  580.  0.183  -0.0182           104        36
       9     9   133 1052.  739. -0.291   0.00758          126        41
      10    10   137 1026.  739. -0.209  -0.00691          122        41
      # ... with 90 more rows

# Default behavior works for Dual Task Paradigm

    Code
      preproc_data(data_dualtask, cpt)
    Output
      # A tibble: 100 x 8
            id    nc   mrt  rtsd  dprime       c commissions omissions
         <int> <int> <dbl> <dbl>   <dbl>   <dbl>       <int>     <int>
       1     1   148 1037.  793. -0.0249 -0.0909          85        67
       2     2   131 1203.  878. -0.311   0.0863          76        93
       3     3   154  998.  721.  0.0692 -0.0346          78        68
       4     4   139 1023.  878. -0.188   0.0467          82        79
       5     5   162 1063.  748.  0.203   0.0374          64        74
       6     6   142  969.  740. -0.129  -0.0177          89        69
       7     7   153  843.  666.  0.0499 -0.0582          77        70
       8     8   158 1170. 1018.  0.132   0.0158          71        71
       9     9   148 1019.  795. -0.0284  0.0407          69        83
      10    10   161  916.  799.  0.183   0.0340          67        72
      # ... with 90 more rows

# Works on perfect accuracy data (no `NA`s)

    Code
      preproc_data(data_perfect, cpt)
    Output
      # A tibble: 1 x 8
           id    nc   mrt  rtsd dprime     c commissions omissions
        <dbl> <int> <dbl> <dbl>  <dbl> <dbl>       <int>     <int>
      1     1    10  810.  849.   2.56 0.313           0         0

# Works with multiple grouping variables

    Code
      preproc_data(data, cpt, by = c("id", "id1"))
    Output
      # A tibble: 100 x 9
            id   id1    nc   mrt  rtsd  dprime         c commissions omissions
         <int> <dbl> <int> <dbl> <dbl>   <dbl>     <dbl>       <int>     <int>
       1     1     2   144  919.  788. -0.146   0.0457           116        40
       2     2     3   146  814.  475. -0.0660 -0.000434         115        39
       3     3     4   145  758.  478. -0.0874  0.00452          115        40
       4     4     5   169  996.  819.  0.346  -0.0289           100        31
       5     5     6   152  946.  745. -0.0335  0.0740           104        44
       6     6     7   160 1312. 1015.  0.0682  0.0894           105        35
       7     7     8   155  939.  634.  0.194  -0.114            113        32
       8     8     9   160  827.  580.  0.183  -0.0182           104        36
       9     9    10   133 1052.  739. -0.291   0.00758          126        41
      10    10    11   137 1026.  739. -0.209  -0.00691          122        41
      # ... with 90 more rows

