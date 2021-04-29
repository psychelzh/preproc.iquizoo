# Should return with attributes (meta information):

    Code
      wrangle_data(data)
    Output
      # A tibble: 5 x 3
          .id     a     b
      * <int> <int> <int>
      1     1     1     1
      2     1     2     2
      3     1     3     3
      4     1     4     4
      5     1     5     5
      * Name of key: '.id'
      * Meta of 1 obs and 4 vars

# Remove duplicates

    Code
      parsed_dup
    Output
      # A tibble: 8 x 3
          .id     a     b
      * <int> <int> <int>
      1     1     1     1
      2     1     2     2
      3     1     3     3
      4     1     4     4
      5     1     5     5
      6     2     2     1
      7     2     3     2
      8     2     4     3
      * Name of key: '.id'
      * Meta of 2 obs and 2 vars

