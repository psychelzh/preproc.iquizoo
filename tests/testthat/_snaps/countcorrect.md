# Test `countcorrect()`: Associative Lang game (new version)

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_assoclang_new.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc     pc is_normal
        <int>  <dbl> <lgl>    
      1     3 0.0476 TRUE     

# Test `countcorrect()`: Associative Lang game (old version)

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_assoclang_old.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    17 0.293 TRUE     

# Test `countcorrect()`: Attention Search

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_attsearch.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    53     1 TRUE     

# Test `countcorrect()`: Calculation

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_calc.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    24 0.453 TRUE     

# Test `countcorrect()`: Calculation (junior version)

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_calcjr.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    70 0.921 TRUE     

# Test `countcorrect()`: Calculation (medium version)

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_calcmed.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1   115 0.950 TRUE     

# Test `countcorrect()`: Five Point Test

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_fpt.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    49 0.662 TRUE     

# Test `countcorrect()`: Lexic Judgment

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_lexic.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    86 0.573 TRUE     

# Test `countcorrect()`: Number Sets

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_numsets.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    85 0.425 TRUE     

# Test `countcorrect()`: Orthography Judgment

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_ortho.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    88  0.88 TRUE     

# Test `countcorrect()`: Pinyin Judgment

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_pinyin.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    76 0.507 TRUE     

# Test `countcorrect()`: Semantic Judgment

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_seman.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    73 0.487 TRUE     

# Test `countcorrect()`: Symbol Judgment

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_symbol.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1   141  0.94 TRUE     

# Test `countcorrect()`: Tone Judgment

    Code
      countcorrect(jsonlite::read_json("data/countcorrect/sample_tone.json",
        simplifyVector = TRUE))
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <int> <dbl> <lgl>    
      1    56 0.373 TRUE     

# Test `countcorrect()`: corrupted data

    Code
      countcorrect(data.frame())
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <dbl> <dbl> <lgl>    
      1    NA    NA FALSE    

---

    Code
      countcorrect(1)
    Warning <simpleWarning>
      At least one of the required variables are missing.
    Output
      # A tibble: 1 x 3
           nc    pc is_normal
        <dbl> <dbl> <lgl>    
      1    NA    NA FALSE    

