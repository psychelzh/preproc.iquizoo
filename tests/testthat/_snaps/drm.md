# Test `drm()`: DRM paradigm

    Code
      drm(jsonlite::read_json("data/drm/sample_drm.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 7
           pc hit_rate p_old_lure p_old_foil fm_ratio fm_dprime is_normal
        <dbl>    <dbl>      <dbl>      <dbl>    <dbl>     <dbl> <lgl>    
      1 0.833    0.844      0.281     0.0625    0.219     0.955 TRUE     

# Test `drm()`: corrupted data

    Code
      drm(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 7
           pc hit_rate p_old_lure p_old_foil fm_ratio fm_dprime is_normal
        <dbl>    <dbl>      <dbl>      <dbl>    <dbl>     <dbl> <lgl>    
      1    NA       NA         NA         NA       NA        NA FALSE    

---

    Code
      drm(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 7
           pc hit_rate p_old_lure p_old_foil fm_ratio fm_dprime is_normal
        <dbl>    <dbl>      <dbl>      <dbl>    <dbl>     <dbl> <lgl>    
      1    NA       NA         NA         NA       NA        NA FALSE    

