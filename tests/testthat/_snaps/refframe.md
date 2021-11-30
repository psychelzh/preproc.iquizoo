# Default behavior works

    Code
      preproc(data, refframe, .by = "id")
    Output
      # A tibble: 100 x 7
            id mean_dist_err_allo mean_dist_err_both mean_dist_err_e~ mean_log_err_al~
         <int>              <dbl>              <dbl>            <dbl>            <dbl>
       1     1              103.               102.             101.              4.43
       2     2              115.               103.              90.8             4.64
       3     3               99.3              103.             106.              4.46
       4     4              114.               103.              92.1             4.58
       5     5               95.4              101.             107.              4.29
       6     6               93.6              105.             117.              4.38
       7     7              111.                97.4             83.7             4.54
       8     8              120.               105.              90.4             4.60
       9     9              104.                95.5             87.3             4.50
      10    10               63.4               65.2             66.9             3.80
      # ... with 90 more rows, and 2 more variables: mean_log_err_both <dbl>,
      #   mean_log_err_ego <dbl>

# Works with multiple grouping variables

    Code
      preproc(data, refframe, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 8
            id   id1 mean_dist_err_allo mean_dist_err_both mean_dist_err_ego
         <int> <dbl>              <dbl>              <dbl>             <dbl>
       1     1     2              103.               102.              101. 
       2     2     3              115.               103.               90.8
       3     3     4               99.3              103.              106. 
       4     4     5              114.               103.               92.1
       5     5     6               95.4              101.              107. 
       6     6     7               93.6              105.              117. 
       7     7     8              111.                97.4              83.7
       8     8     9              120.               105.               90.4
       9     9    10              104.                95.5              87.3
      10    10    11               63.4               65.2              66.9
      # ... with 90 more rows, and 3 more variables: mean_log_err_allo <dbl>,
      #   mean_log_err_both <dbl>, mean_log_err_ego <dbl>

