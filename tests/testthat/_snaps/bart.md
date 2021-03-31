# Default behavior works

    Code
      preproc_data(data, bart)
    Output
      # A tibble: 1,000 x 4
            id mean_pumps mean_pumps_raw num_explosion
         <int>      <dbl>          <dbl>         <int>
       1     1       0.96           2.02            51
       2     2       0.87           2.07            55
       3     3       0.88           1.73            48
       4     4       1.18           2.07            47
       5     5       1.1            2.05            47
       6     6       0.96           2.09            55
       7     7       0.87           2.01            55
       8     8       0.86           2.04            51
       9     9       1.02           1.96            50
      10    10       1.17           2.07            47
      # ... with 990 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, bart, by = c("id", "id1"))
    Output
      # A tibble: 1,000 x 5
            id   id1 mean_pumps mean_pumps_raw num_explosion
         <int> <int>      <dbl>          <dbl>         <int>
       1     1  1000       0.96           2.02            51
       2     2   999       0.87           2.07            55
       3     3   998       0.88           1.73            48
       4     4   997       1.18           2.07            47
       5     5   996       1.1            2.05            47
       6     6   995       0.96           2.09            55
       7     7   994       0.87           2.01            55
       8     8   993       0.86           2.04            51
       9     9   992       1.02           1.96            50
      10    10   991       1.17           2.07            47
      # ... with 990 more rows

