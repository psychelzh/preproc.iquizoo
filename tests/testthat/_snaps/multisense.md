# Test `multisense()`: Multisense Test

    Code
      multisense(jsonlite::read_json("data/multisense/sample_multisense.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 5
        mrt_image mrt_sound mrt_mixed mrt_mixadv is_normal
            <dbl>     <dbl>     <dbl>      <dbl> <lgl>    
      1      464.      434.      447.       2.19 TRUE     

# Test `multisense()`: Multisense Test (no sound responses)

    Code
      multisense(jsonlite::read_json(
        "data/multisense/sample_multisense_no_sound.json", simplifyVector = TRUE))
    Output
      # A tibble: 1 x 5
        mrt_image mrt_sound mrt_mixed mrt_mixadv is_normal
            <dbl>     <dbl>     <dbl>      <dbl> <lgl>    
      1      575.       NaN      585.        NaN TRUE     

# Test `multisense()`: corrupted data

    Code
      multisense(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 5
        mrt_image mrt_sound mrt_mixed mrt_mixadv is_normal
        <lgl>     <lgl>     <lgl>     <lgl>      <lgl>    
      1 NA        NA        NA        NA         FALSE    

---

    Code
      multisense(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 5
        mrt_image mrt_sound mrt_mixed mrt_mixadv is_normal
        <lgl>     <lgl>     <lgl>     <lgl>      <lgl>    
      1 NA        NA        NA        NA         FALSE    

