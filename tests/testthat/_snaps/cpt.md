# `cpt()` should work on sample data

    Code
      cpt(sample_data)
    Output
      # A tibble: 1 x 10
           pc dprime     c  hits commissions omissions count_error   mrt  rtsd
        <dbl>  <dbl> <dbl> <int>       <int>     <int>       <int> <dbl> <dbl>
      1     1   4.33 0.435    12           0         0           0  280.  86.8
      # ... with 1 more variable: is_normal <lgl>

