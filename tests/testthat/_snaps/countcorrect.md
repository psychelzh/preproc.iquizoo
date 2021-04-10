# Default behavior works on different types of input

    Code
      preproc_data(data_cancellation, countcorrect, by = "id")
    Output
      # A tibble: 100 x 2
            id    nc
         <int> <int>
       1     1    86
       2     2   120
       3     3   118
       4     4   136
       5     5    76
       6     6    56
       7     7   138
       8     8    68
       9     9    99
      10    10    56
      # ... with 90 more rows

---

    Code
      preproc_data(data_canteen, countcorrect, by = "id")
    Output
      # A tibble: 100 x 2
            id    nc
         <int> <int>
       1     1    36
       2     2    28
       3     3    42
       4     4    51
       5     5    17
       6     6    31
       7     7    25
       8     8    29
       9     9    41
      10    10    35
      # ... with 90 more rows

---

    Code
      preproc_data(data_fpt, countcorrect, by = "id")
    Output
      # A tibble: 100 x 2
            id    nc
         <int> <int>
       1     1    33
       2     2    35
       3     3    29
       4     4    31
       5     5    29
       6     6    26
       7     7    35
       8     8    37
       9     9    28
      10    10    24
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc_data(data_cancellation, countcorrect, by = c("id", "id1"))
    Output
      # A tibble: 100 x 3
            id   id1    nc
         <int> <dbl> <int>
       1     1     2    86
       2     2     3   120
       3     3     4   118
       4     4     5   136
       5     5     6    76
       6     6     7    56
       7     7     8   138
       8     8     9    68
       9     9    10    99
      10    10    11    56
      # ... with 90 more rows

