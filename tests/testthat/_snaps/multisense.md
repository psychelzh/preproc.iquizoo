# Default behavior works

    Code
      preproc(data, multisense, by = "id")
    Output
      # A tibble: 100 x 5
            id mrt_image mrt_sound mrt_mixed mrt_mixadv
         <int>     <dbl>     <dbl>     <dbl>      <dbl>
       1     1      804.      767.      918.     -133. 
       2     2     1493.      865.      980.      200. 
       3     3      794.     1186.     1358.     -367. 
       4     4      669.      753.      776.      -64.4
       5     5      956.     1283.      729.      390. 
       6     6     1312.      648.     1074.      -93.9
       7     7      798.     1076.      668.      269. 
       8     8      940.     1051.      827.      168. 
       9     9      622.      920.     1821.    -1051. 
      10    10      813.      872.      802.       41.2
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, multisense, by = c("id", "id1"))
    Output
      # A tibble: 100 x 6
            id   id1 mrt_image mrt_sound mrt_mixed mrt_mixadv
         <int> <dbl>     <dbl>     <dbl>     <dbl>      <dbl>
       1     1     2      804.      767.      918.     -133. 
       2     2     3     1493.      865.      980.      200. 
       3     3     4      794.     1186.     1358.     -367. 
       4     4     5      669.      753.      776.      -64.4
       5     5     6      956.     1283.      729.      390. 
       6     6     7     1312.      648.     1074.      -93.9
       7     7     8      798.     1076.      668.      269. 
       8     8     9      940.     1051.      827.      168. 
       9     9    10      622.      920.     1821.    -1051. 
      10    10    11      813.      872.      802.       41.2
      # ... with 90 more rows

