# Test `dualtask()`: Dual Task Paradigm

    Code
      dualtask(jsonlite::read_json("data/dualtask/sample_dualtask.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 10
        mrt_left mrt_right mrt_all nc_left nc_right nc_all dprime_left dprime_right
           <dbl>     <dbl>   <dbl>   <int>    <int>  <int>       <dbl>        <dbl>
      1     840.      816.    827.      53       60    113       0.186        0.531
      # ... with 2 more variables: dprime_all <dbl>, is_normal <lgl>

# Test `dualtask()`: corrupted data

    Code
      dualtask(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 10
        mrt_all mrt_left mrt_right nc_all nc_left nc_right dprime_all dprime_left
        <lgl>   <lgl>    <lgl>     <lgl>  <lgl>   <lgl>    <lgl>      <lgl>      
      1 NA      NA       NA        NA     NA      NA       NA         NA         
      # ... with 2 more variables: dprime_right <lgl>, is_normal <lgl>

---

    Code
      dualtask(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 10
        mrt_all mrt_left mrt_right nc_all nc_left nc_right dprime_all dprime_left
        <lgl>   <lgl>    <lgl>     <lgl>  <lgl>   <lgl>    <lgl>      <lgl>      
      1 NA      NA       NA        NA     NA      NA       NA         NA         
      # ... with 2 more variables: dprime_right <lgl>, is_normal <lgl>

