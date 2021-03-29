# Support `group = NULL` by deleting group variable afterward

    Code
      preproc_data(data, bart, by = NULL)
    Output
      # A tibble: 1 x 4
        mean_pumps mean_pumps_raw num_explosion is_normal
      *      <dbl>          <dbl>         <dbl> <lgl>    
      1          0              1             0 TRUE     

