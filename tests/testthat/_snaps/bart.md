# `bart()` default

    Code
      preproc_data(data, bart)
    Output
      # A tibble: 1,000 x 5
            id mean_pumps mean_pumps_raw num_explosion is_normal
       * <int>      <dbl>          <dbl>         <dbl> <lgl>    
       1     1       0.96           2.02            49 TRUE     
       2     2       0.87           2.07            45 TRUE     
       3     3       0.88           1.73            52 TRUE     
       4     4       1.18           2.07            53 TRUE     
       5     5       1.1            2.05            53 TRUE     
       6     6       0.96           2.09            45 TRUE     
       7     7       0.87           2.01            45 TRUE     
       8     8       0.86           2.04            49 TRUE     
       9     9       1.02           1.96            50 TRUE     
      10    10       1.17           2.07            53 TRUE     
      # ... with 990 more rows

# `bart()` supports no group

    Code
      preproc_data(data, bart, by = NULL)
    Output
      # A tibble: 1 x 4
        mean_pumps mean_pumps_raw num_explosion is_normal
      *      <dbl>          <dbl>         <dbl> <lgl>    
      1       1.00           2.00         50170 TRUE     

