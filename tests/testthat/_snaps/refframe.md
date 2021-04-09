# Default behavior works

    Code
      preproc_data(data, refframe)
    Output
      # A tibble: 100 x 5
            id mean_dist_err_allo mean_dist_err_ego mean_log_err_allo mean_log_err_ego
         <int>              <dbl>             <dbl>             <dbl>            <dbl>
       1     1              103.              101.               4.43             4.32
       2     2              115.               90.8              4.64             4.22
       3     3               99.3             106.               4.46             4.49
       4     4              114.               92.1              4.58             4.19
       5     5               95.4             107.               4.29             4.54
       6     6               93.6             117.               4.38             4.63
       7     7              111.               83.7              4.54             4.26
       8     8              120.               90.4              4.60             4.35
       9     9              104.               87.3              4.50             4.24
      10    10               63.4              66.9              3.80             3.88
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, refframe, by = c("id", "id1"))
    Output
      # A tibble: 100 x 6
            id   id1 mean_dist_err_allo mean_dist_err_ego mean_log_err_allo
         <int> <dbl>              <dbl>             <dbl>             <dbl>
       1     1     2              103.              101.               4.43
       2     2     3              115.               90.8              4.64
       3     3     4               99.3             106.               4.46
       4     4     5              114.               92.1              4.58
       5     5     6               95.4             107.               4.29
       6     6     7               93.6             117.               4.38
       7     7     8              111.               83.7              4.54
       8     8     9              120.               90.4              4.60
       9     9    10              104.               87.3              4.50
      10    10    11               63.4              66.9              3.80
      # ... with 90 more rows, and 1 more variable: mean_log_err_ego <dbl>

