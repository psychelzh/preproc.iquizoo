# Default behavior works

    Code
      preproc(data, jlo, by = "id")
    Output
      # A tibble: 100 x 4
            id    nc mean_ang_err mean_log_err
         <int> <int>        <dbl>        <dbl>
       1     1     0         56.2        0.676
       2     2     0         52.5        0.648
       3     3     0         53.2        0.642
       4     4     0         40.5        0.515
       5     5     0         38.2        0.502
       6     6     0         35.2        0.445
       7     7     0         42          0.539
       8     8     0         46.5        0.595
       9     9     0         51          0.615
      10    10     0         44.2        0.559
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, jlo, by = c("id", "id1"))
    Output
      # A tibble: 100 x 5
            id   id1    nc mean_ang_err mean_log_err
         <int> <dbl> <int>        <dbl>        <dbl>
       1     1     2     0         56.2        0.676
       2     2     3     0         52.5        0.648
       3     3     4     0         53.2        0.642
       4     4     5     0         40.5        0.515
       5     5     6     0         38.2        0.502
       6     6     7     0         35.2        0.445
       7     7     8     0         42          0.539
       8     8     9     0         46.5        0.595
       9     9    10     0         51          0.615
      10    10    11     0         44.2        0.559
      # ... with 90 more rows

