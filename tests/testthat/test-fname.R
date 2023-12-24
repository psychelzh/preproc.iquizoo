test_that("Works without grouping variables", {
  withr::local_seed(1)
  data <- tibble(phase = rep(c(3, 5, 6), each = 10)) |>
    mutate(
      acc = if_else(
        phase != 6,
        as.character(sample(c(0, 1), n(), replace = TRUE)),
        purrr::map_chr(
          seq_len(n()),
          ~ sample(c(0, 1), 2, replace = TRUE) |>
            stringr::str_c(collapse = "-")
        )
      )
    )
  fname(data) |>
    expect_snapshot_value(style = "json2")
})

test_that("Works with grouping variables", {
  withr::local_seed(1)
  data <- expand_grid(
    id = 1:2,
    tibble(phase = rep(c(3, 5, 6), each = 10)) |>
      mutate(
        acc = if_else(
          phase != 6,
          as.character(sample(c(0, 1), n(), replace = TRUE)),
          purrr::map_chr(
            seq_len(n()),
            ~ sample(c(0, 1), 2, replace = TRUE) |>
              stringr::str_c(collapse = "-")
          )
        )
      )
  )
  fname(data, .by = "id") |>
    expect_snapshot_value(style = "json2")
})
