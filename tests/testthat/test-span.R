data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    trial = 1:14
  ) |>
    group_by(id) |>
    mutate(
      outcome = sample(
        c(0, 1),
        n(),
        replace = TRUE,
        prob = c(0.2, 0.8)
      ),
      slen = prepare_level(
        outcome, 1, 1,
        level_init = 3,
        level_limits = c(2, 16)
      )
    ) |>
    rowwise() |>
    mutate(
      correctness = ifelse(
        outcome == 1,
        stringr::str_c(rep(1, slen), collapse = "-"),
        stringr::str_c(
          sample(c(0, 1), slen, replace = TRUE),
          collapse = "-"
        )
      )
    ) |>
    ungroup()
)

test_that("Default behavior works", {
  expect_snapshot_value(
    span(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    span(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works when no acc column found", {
  data_no_acc <- withr::with_seed(
    1,
    tibble(trial = 1:14) |>
      mutate(
        outcome = sample(
          c(0, 1),
          n(),
          replace = TRUE,
          prob = c(0.2, 0.8)
        )
      ) |>
      mutate(
        slen = prepare_level(
          outcome, 1, 1,
          level_init = 3,
          level_limits = c(2, 16)
        )
      )
  )
  span(data_no_acc) |>
    expect_silent() |>
    expect_snapshot_value(style = "json2")
  data_repairable <- withr::with_seed(
    1,
    data_no_acc |>
      mutate(
        stim = purrr::map_chr(
          slen, ~ paste(seq_len(.x), collapse = "-")
        ),
        resp = purrr::map_chr(
          slen, ~ paste(sample(seq_len(.x)), collapse = "-")
        )
      )
  )
  span(data_repairable) |>
    expect_silent() |>
    expect_snapshot_value(style = "json2")
})

test_that("Works for distance input", {
  data_dist <- data |>
    mutate(
      resplocdist = correctness |>
        stringr::str_replace_all("0", "99") |>
        stringr::str_replace_all("1", "0"),
      .keep = "unused"
    )
  expect_identical(
    span(data),
    span(data_dist)
  )
})
