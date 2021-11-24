# Default behavior works

    Code
      preproc(data, locmem, .by = "id")
    Output
      # A tibble: 100 x 4
            id nc_loc mean_dist_err mean_log_err
         <int>  <int>         <dbl>        <dbl>
       1     1      0          5.29         1.73
       2     2      0          5.16         1.70
       3     3      0          5.00         1.68
       4     4      0          4.71         1.63
       5     5      0          4.35         1.50
       6     6      0          5.27         1.70
       7     7      0          5.20         1.66
       8     8      0          4.50         1.53
       9     9      0          5.26         1.70
      10    10      0          5.02         1.67
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, locmem, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 5
            id   id1 nc_loc mean_dist_err mean_log_err
         <int> <dbl>  <int>         <dbl>        <dbl>
       1     1     2      0          5.29         1.73
       2     2     3      0          5.16         1.70
       3     3     4      0          5.00         1.68
       4     4     5      0          4.71         1.63
       5     5     6      0          4.35         1.50
       6     6     7      0          5.27         1.70
       7     7     8      0          5.20         1.66
       8     8     9      0          4.50         1.53
       9     9    10      0          5.26         1.70
      10    10    11      0          5.02         1.67
      # ... with 90 more rows

