# Default behavior works

    Code
      preproc(data, multisense, .by = "id")
    Output
      # A tibble: 100 x 5
            id mrt_image mrt_mixed mrt_sound mrt_mixadv
         <int>     <dbl>     <dbl>     <dbl>      <dbl>
       1     1      804.      918.      767.     -133. 
       2     2     1493.      980.      865.      200. 
       3     3      794.     1358.     1186.     -367. 
       4     4      669.      776.      753.      -64.4
       5     5      956.      729.     1283.      390. 
       6     6     1312.     1074.      648.      -93.9
       7     7      798.      668.     1076.      269. 
       8     8      940.      827.     1051.      168. 
       9     9      622.     1821.      920.    -1051. 
      10    10      813.      802.      872.       41.2
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, multisense, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 6
            id   id1 mrt_image mrt_mixed mrt_sound mrt_mixadv
         <int> <dbl>     <dbl>     <dbl>     <dbl>      <dbl>
       1     1     2      804.      918.      767.     -133. 
       2     2     3     1493.      980.      865.      200. 
       3     3     4      794.     1358.     1186.     -367. 
       4     4     5      669.      776.      753.      -64.4
       5     5     6      956.      729.     1283.      390. 
       6     6     7     1312.     1074.      648.      -93.9
       7     7     8      798.      668.     1076.      269. 
       8     8     9      940.      827.     1051.      168. 
       9     9    10      622.     1821.      920.    -1051. 
      10    10    11      813.      802.      872.       41.2
      # ... with 90 more rows

