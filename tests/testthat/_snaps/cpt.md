# Test `cpt()`: Continuous Performance Test

    Code
      cpt(jsonlite::read_json("data/cpt/sample_cpt.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 10
           pc dprime     c  hits commissions omissions count_error   mrt  rtsd
        <dbl>  <dbl> <dbl> <int>       <int>     <int>       <int> <dbl> <dbl>
      1     1   4.37 0.418    12           0         0           0  280.  86.8
      # ... with 1 more variable: is_normal <lgl>

# Test `cpt()`: corrupted data

    Code
      cpt(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 10
           pc dprime     c  hits commissions omissions count_error   mrt  rtsd
        <dbl>  <dbl> <dbl> <dbl>       <dbl>     <dbl>       <dbl> <dbl> <dbl>
      1    NA     NA    NA    NA          NA        NA          NA    NA    NA
      # ... with 1 more variable: is_normal <lgl>

---

    Code
      cpt(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 10
           pc dprime     c  hits commissions omissions count_error   mrt  rtsd
        <dbl>  <dbl> <dbl> <dbl>       <dbl>     <dbl>       <dbl> <dbl> <dbl>
      1    NA     NA    NA    NA          NA        NA          NA    NA    NA
      # ... with 1 more variable: is_normal <lgl>

