# Default behavior works

    Code
      preproc_data(data, igt)
    Output
      # A tibble: 100 x 3
            id sum_outcome perc_good
         <int>       <dbl>     <dbl>
       1     1       71800     0.528
       2     2      129800     0.455
       3     3       47400     0.62 
       4     4      113800     0.494
       5     5       95800     0.528
       6     6      127800     0.5  
       7     7       90800     0.524
       8     8      102800     0.493
       9     9      114000     0.5  
      10    10      127600     0.549
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data, igt, by = c("id", "id1"))
    Output
      # A tibble: 100 x 4
            id   id1 sum_outcome perc_good
         <int> <dbl>       <dbl>     <dbl>
       1     1     2       71800     0.528
       2     2     3      129800     0.455
       3     3     4       47400     0.62 
       4     4     5      113800     0.494
       5     5     6       95800     0.528
       6     6     7      127800     0.5  
       7     7     8       90800     0.524
       8     8     9      102800     0.493
       9     9    10      114000     0.5  
      10    10    11      127600     0.549
      # ... with 90 more rows

