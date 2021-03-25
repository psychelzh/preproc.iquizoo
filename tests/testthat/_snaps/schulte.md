# Test `schulte()`: Schulte Grid Test (junior version)

    Code
      schulte(jsonlite::read_json("data/schulte/sample_schultejr.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 2
        net_cor is_normal
          <int> <lgl>    
      1      49 TRUE     

# Test `schulte()`: Schulte Grid Test (medium version)

    Code
      schulte(jsonlite::read_json("data/schulte/sample_schultemed.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 2
        net_cor is_normal
          <int> <lgl>    
      1      33 TRUE     

# Test `schulte()`: Schulte Grid Test (advanced version)

    Code
      schulte(jsonlite::read_json("data/schulte/sample_schulteadv.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 2
        net_cor is_normal
          <int> <lgl>    
      1      71 TRUE     

# Test `schulte()`: corrupted data

    Code
      schulte(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 2
        net_cor is_normal
          <dbl> <lgl>    
      1      NA FALSE    

---

    Code
      schulte(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 2
        net_cor is_normal
          <dbl> <lgl>    
      1      NA FALSE    

