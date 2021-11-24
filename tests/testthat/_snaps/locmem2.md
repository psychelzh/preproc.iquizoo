# Default behavior works

    Code
      preproc(data, locmem2, .by = "id")
    Output
      # A tibble: 100 x 5
            id nc_loc mean_dist_err mean_log_err nc_order
         <int>  <int>         <dbl>        <dbl>    <int>
       1     1      0          5.31         1.67       23
       2     2      0          4.77         1.55       37
       3     3      0          5.33         1.67       36
       4     4      0          4.79         1.61       37
       5     5      0          4.99         1.64       39
       6     6      0          5.11         1.66       21
       7     7      0          4.62         1.51       33
       8     8      0          5.00         1.64       30
       9     9      0          4.33         1.48       29
      10    10      0          5.12         1.64       29
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, locmem2, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 6
            id   id1 nc_loc mean_dist_err mean_log_err nc_order
         <int> <dbl>  <int>         <dbl>        <dbl>    <int>
       1     1     2      0          5.31         1.67       23
       2     2     3      0          4.77         1.55       37
       3     3     4      0          5.33         1.67       36
       4     4     5      0          4.79         1.61       37
       5     5     6      0          4.99         1.64       39
       6     6     7      0          5.11         1.66       21
       7     7     8      0          4.62         1.51       33
       8     8     9      0          5.00         1.64       30
       9     9    10      0          4.33         1.48       29
      10    10    11      0          5.12         1.64       29
      # ... with 90 more rows

