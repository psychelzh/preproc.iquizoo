# Default behavior works

    Code
      preproc_data(data, refframe, by = "id")
    Output
      # A tibble: 100 x 7
            id mean_dist_err_allo mean_log_err_allo mean_dist_err_ego mean_log_err_ego
         <int>              <dbl>             <dbl>             <dbl>            <dbl>
       1     1              103.               4.43             101.              4.32
       2     2              115.               4.64              90.8             4.22
       3     3               99.3              4.46             106.              4.49
       4     4              114.               4.58              92.1             4.19
       5     5               95.4              4.29             107.              4.54
       6     6               93.6              4.38             117.              4.63
       7     7              111.               4.54              83.7             4.26
       8     8              120.               4.60              90.4             4.35
       9     9              104.               4.50              87.3             4.24
      10    10               63.4              3.80              66.9             3.88
      # ... with 90 more rows, and 2 more variables: mean_dist_err_both <dbl>,
      #   mean_log_err_both <dbl>

# Works with multiple grouping variables

    Code
      preproc_data(data, refframe, by = c("id", "id1"))
    Output
      # A tibble: 100 x 8
            id   id1 mean_dist_err_allo mean_log_err_allo mean_dist_err_ego
         <int> <dbl>              <dbl>             <dbl>             <dbl>
       1     1     2              103.               4.43             101. 
       2     2     3              115.               4.64              90.8
       3     3     4               99.3              4.46             106. 
       4     4     5              114.               4.58              92.1
       5     5     6               95.4              4.29             107. 
       6     6     7               93.6              4.38             117. 
       7     7     8              111.               4.54              83.7
       8     8     9              120.               4.60              90.4
       9     9    10              104.               4.50              87.3
      10    10    11               63.4              3.80              66.9
      # ... with 90 more rows, and 3 more variables: mean_log_err_ego <dbl>,
      #   mean_dist_err_both <dbl>, mean_log_err_both <dbl>

