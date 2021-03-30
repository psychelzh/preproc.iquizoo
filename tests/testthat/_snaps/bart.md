# `bart()` default

    Code
      preproc_data(data, bart)
    Output
      # A tibble: 1,000 x 5
            id mean_pumps mean_pumps_raw num_explosion is_normal
         <int>      <dbl>          <dbl>         <int> <lgl>    
       1     1       0.96           2.02            51 TRUE     
       2     2       0.87           2.07            55 TRUE     
       3     3       0.88           1.73            48 TRUE     
       4     4       1.18           2.07            47 TRUE     
       5     5       1.1            2.05            47 TRUE     
       6     6       0.96           2.09            55 TRUE     
       7     7       0.87           2.01            55 TRUE     
       8     8       0.86           2.04            51 TRUE     
       9     9       1.02           1.96            50 TRUE     
      10    10       1.17           2.07            47 TRUE     
      # ... with 990 more rows

# `bart()` works with multiple grouping variables

    Code
      preproc_data(data, bart, by = c("id1", "id2"))
    Output
      # A tibble: 1,000 x 6
           id1   id2 mean_pumps mean_pumps_raw num_explosion is_normal
         <int> <int>      <dbl>          <dbl>         <int> <lgl>    
       1     1  1000       1.16           2.01            45 TRUE     
       2     2   999       1.08           1.98            47 TRUE     
       3     3   998       1.07           2.08            51 TRUE     
       4     4   997       1.01           1.93            46 TRUE     
       5     5   996       1.13           1.98            40 TRUE     
       6     6   995       1.25           2.24            45 TRUE     
       7     7   994       1.06           2.09            46 TRUE     
       8     8   993       0.84           1.87            52 TRUE     
       9     9   992       0.9            1.79            52 TRUE     
      10    10   991       1.08           1.81            43 TRUE     
      # ... with 990 more rows

