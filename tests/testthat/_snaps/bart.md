# Default behavior works

    Code
      preproc(data, bart, by = "id")
    Output
      # A tibble: 1,000 x 4
            id mean_pumps mean_pumps_raw num_explosion
         <int>      <dbl>          <dbl>         <int>
       1     1       1.96           2.02            51
       2     2       1.93           2.07            55
       3     3       1.69           1.73            48
       4     4       2.23           2.07            47
       5     5       2.08           2.05            47
       6     6       2.13           2.09            55
       7     7       1.93           2.01            55
       8     8       1.76           2.04            51
       9     9       2.04           1.96            50
      10    10       2.21           2.07            47
      # ... with 990 more rows

# Works with multiple grouping variables

    Code
      preproc(data, bart, by = c("id", "id1"))
    Output
      # A tibble: 1,000 x 5
            id   id1 mean_pumps mean_pumps_raw num_explosion
         <int> <dbl>      <dbl>          <dbl>         <int>
       1     1     2       1.96           2.02            51
       2     2     3       1.93           2.07            55
       3     3     4       1.69           1.73            48
       4     4     5       2.23           2.07            47
       5     5     6       2.08           2.05            47
       6     6     7       2.13           2.09            55
       7     7     8       1.93           2.01            55
       8     8     9       1.76           2.04            51
       9     9    10       2.04           1.96            50
      10    10    11       2.21           2.07            47
      # ... with 990 more rows

