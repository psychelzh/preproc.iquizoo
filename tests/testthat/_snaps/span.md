# Default behavior works

    Code
      preproc(data, span, .by = "id")
    Output
      # A tibble: 100 x 4
            id    nc max_span mean_span
         <int> <int>    <dbl>     <dbl>
       1     1    71       10      9.5 
       2     2    91       12     11.7 
       3     3   104       12     10.5 
       4     4   116       14     14   
       5     5   100       13     12.5 
       6     6    55        8      6.67
       7     7   116       14     14   
       8     8    89       10      8.33
       9     9   115       14     14   
      10    10   105       12     11.5 
      # ... with 90 more rows

# Works with multiple grouping variables

    Code
      preproc(data, span, .by = c("id", "id1"))
    Output
      # A tibble: 100 x 5
            id   id1    nc max_span mean_span
         <int> <dbl> <int>    <dbl>     <dbl>
       1     1     2    71       10      9.5 
       2     2     3    91       12     11.7 
       3     3     4   104       12     10.5 
       4     4     5   116       14     14   
       5     5     6   100       13     12.5 
       6     6     7    55        8      6.67
       7     7     8   116       14     14   
       8     8     9    89       10      8.33
       9     9    10   115       14     14   
      10    10    11   105       12     11.5 
      # ... with 90 more rows

# Works when no acc column found

    Code
      result_no_acc
    Output
      # A tibble: 100 x 4
            id    nc max_span mean_span
         <int> <int>    <dbl>     <dbl>
       1     1    NA       10      8.58
       2     2    NA       14     14   
       3     3    NA       16     15.5 
       4     4    NA       14     14   
       5     5    NA       12     11.5 
       6     6    NA       12     11.8 
       7     7    NA        8      6   
       8     8    NA        7      5.05
       9     9    NA        8      7   
      10    10    NA        9      7.67
      # ... with 90 more rows

---

    Code
      result_repaired
    Output
      # A tibble: 100 x 4
            id    nc max_span mean_span
         <int> <int>    <dbl>     <dbl>
       1     1    14       10      8.58
       2     2    11       14     14   
       3     3    18       16     15.5 
       4     4    14       14     14   
       5     5    16       12     11.5 
       6     6    21       12     11.8 
       7     7     9        8      6   
       8     8     9        7      5.05
       9     9    13        8      7   
      10    10    16        9      7.67
      # ... with 90 more rows

