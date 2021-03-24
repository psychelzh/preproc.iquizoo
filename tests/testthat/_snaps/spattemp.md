# Test `spattemp()`: Camera (hide version)

    Code
      spattemp(jsonlite::read_json("data/spattemp/sample_camera.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        pc_order pc_loc mean_dist is_normal
           <dbl>  <dbl>     <dbl> <lgl>    
      1    0.762  0.929     0.178 TRUE     

# Test `spattemp()`: Camera (stay version)

    Code
      spattemp(jsonlite::read_json("data/spattemp/sample_camera2.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        pc_order pc_loc mean_dist is_normal
           <dbl>  <dbl>     <dbl> <lgl>    
      1    0.846  0.558     0.761 TRUE     

# Test `spattemp()`: Camera (junior version)

    Code
      spattemp(jsonlite::read_json("data/spattemp/sample_camerajr.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        pc_order pc_loc mean_dist is_normal
           <dbl>  <dbl>     <dbl> <lgl>    
      1     0.75      0      6.28 TRUE     

# Test `spattemp()`: Camera (medium version)

    Code
      spattemp(jsonlite::read_json("data/spattemp/sample_cameramed.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 4
        pc_order pc_loc mean_dist is_normal
           <dbl>  <dbl>     <dbl> <lgl>    
      1    0.881      0      5.67 TRUE     

# Test `spattemp()`: corrupted data

    Code
      spattemp(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        pc_order pc_loc mean_dist is_normal
        <lgl>    <lgl>  <lgl>     <lgl>    
      1 NA       NA     NA        FALSE    

---

    Code
      spattemp(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 4
        pc_order pc_loc mean_dist is_normal
        <lgl>    <lgl>  <lgl>     <lgl>    
      1 NA       NA     NA        FALSE    

