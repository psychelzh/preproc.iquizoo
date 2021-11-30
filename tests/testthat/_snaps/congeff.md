# Default behavior works

    Code
      preproc(data, congeff, .by = "id")
    Output
      # A tibble: 100 x 7
            id mrt_inc mrt_con pc_inc pc_con cong_eff_rt cong_eff_pc
         <int>   <dbl>   <dbl>  <dbl>  <dbl>       <dbl>       <dbl>
       1     1    960.    927.  0.489  0.495       33.1     0.00533 
       2     2    903.    998.  0.501  0.511      -95.2     0.0105  
       3     3    959.    937.  0.483  0.490       22.6     0.00763 
       4     4    951.    918.  0.478  0.511       33.5     0.0329  
       5     5    963.    926.  0.498  0.499       37.3     0.00127 
       6     6    945.    952.  0.489  0.486       -6.78   -0.00280 
       7     7    979.    983.  0.512  0.468       -3.70   -0.0441  
       8     8    910.    959.  0.485  0.486      -48.7     0.000999
       9     9    975.    965.  0.505  0.496       10.1    -0.00864 
      10    10    992.    954.  0.483  0.492       38.9     0.00963 
      # ... with 90 more rows

# All single condition

    Code
      preproc(data_miss_cond, congeff, .by = "id")
    Output
      # A tibble: 2 x 7
           id mrt_inc mrt_con pc_inc pc_con cong_eff_rt cong_eff_pc
        <int>   <dbl>   <dbl>  <dbl>  <dbl>       <dbl>       <dbl>
      1     1    866.      NA  0.875     NA          NA          NA
      2     2    519.      NA  0.5       NA          NA          NA

# Part subject single condition

    Code
      preproc(data_part_miss_cond, congeff, .by = "id")
    Output
      # A tibble: 2 x 7
           id mrt_inc mrt_con pc_inc pc_con cong_eff_rt cong_eff_pc
        <int>   <dbl>   <dbl>  <dbl>  <dbl>       <dbl>       <dbl>
      1     1    845.     NA    0.25   NA           NA        NA   
      2     2    631.    526.   0.75    0.5        105.       -0.25

# Works with multiple grouping variables

    Code
      preproc(data, congeff, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 8
            id   id1 mrt_inc mrt_con pc_inc pc_con cong_eff_rt cong_eff_pc
         <int> <dbl>   <dbl>   <dbl>  <dbl>  <dbl>       <dbl>       <dbl>
       1     1     2    960.    927.  0.489  0.495       33.1     0.00533 
       2     2     3    903.    998.  0.501  0.511      -95.2     0.0105  
       3     3     4    959.    937.  0.483  0.490       22.6     0.00763 
       4     4     5    951.    918.  0.478  0.511       33.5     0.0329  
       5     5     6    963.    926.  0.498  0.499       37.3     0.00127 
       6     6     7    945.    952.  0.489  0.486       -6.78   -0.00280 
       7     7     8    979.    983.  0.512  0.468       -3.70   -0.0441  
       8     8     9    910.    959.  0.485  0.486      -48.7     0.000999
       9     9    10    975.    965.  0.505  0.496       10.1    -0.00864 
      10    10    11    992.    954.  0.483  0.492       38.9     0.00963 
      # ... with 90 more rows

