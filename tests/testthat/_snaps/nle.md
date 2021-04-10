# Default behavior works

    Code
      preproc_data(data, nle, by = "id")
    Output
      # A tibble: 100 x 3
            id mean_abs_err mean_log_err
         <int>        <dbl>        <dbl>
       1     1         34.3         3.35
       2     2         29.6         3.17
       3     3         26.6         2.89
       4     4         31.8         3.22
       5     5         25.8         2.93
       6     6         31.3         3.30
       7     7         31.0         3.09
       8     8         34.7         3.21
       9     9         34.8         3.19
      10    10         31.0         3.06
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, nle, by = c("id", "id1"))
    Output
      # A tibble: 100 x 4
            id   id1 mean_abs_err mean_log_err
         <int> <dbl>        <dbl>        <dbl>
       1     1     2         34.3         3.35
       2     2     3         29.6         3.17
       3     3     4         26.6         2.89
       4     4     5         31.8         3.22
       5     5     6         25.8         2.93
       6     6     7         31.3         3.30
       7     7     8         31.0         3.09
       8     8     9         34.7         3.21
       9     9    10         34.8         3.19
      10    10    11         31.0         3.06
      # ... with 90 more rows

