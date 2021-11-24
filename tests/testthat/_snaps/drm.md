# Default behavior works

    Code
      preproc(data, drm, .by = "id")
    Output
      # A tibble: 100 x 5
            id tm_dprime tm_bias fm_dprime   fm_bias
         <int>     <dbl>   <dbl>     <dbl>     <dbl>
       1     1    0.164   0.163     0.751  -1.30e- 1
       2     2   -0.243   0.0407   -0.162   6.94e-17
       3     3    0.600  -0.300    -0.162   8.12e- 2
       4     4   -0.0826  0.204     0.243   4.07e- 2
       5     5   -0.164   0.163     0.162   6.94e-17
       6     6    0.243   0.0407    0.407  -4.13e- 2
       7     7    0.0809 -0.0405    0.245  -1.23e- 1
       8     8   -0.326   0.0820   -0.162   6.94e-17
       9     9   -0.164  -0.163    -0.245  -1.23e- 1
      10    10   -0.410   0.124     0.0815 -1.22e- 1
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, drm, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 6
            id   id1 tm_dprime tm_bias fm_dprime   fm_bias
         <int> <dbl>     <dbl>   <dbl>     <dbl>     <dbl>
       1     1     2    0.164   0.163     0.751  -1.30e- 1
       2     2     3   -0.243   0.0407   -0.162   6.94e-17
       3     3     4    0.600  -0.300    -0.162   8.12e- 2
       4     4     5   -0.0826  0.204     0.243   4.07e- 2
       5     5     6   -0.164   0.163     0.162   6.94e-17
       6     6     7    0.243   0.0407    0.407  -4.13e- 2
       7     7     8    0.0809 -0.0405    0.245  -1.23e- 1
       8     8     9   -0.326   0.0820   -0.162   6.94e-17
       9     9    10   -0.164  -0.163    -0.245  -1.23e- 1
      10    10    11   -0.410   0.124     0.0815 -1.22e- 1
      # ... with 90 more rows

