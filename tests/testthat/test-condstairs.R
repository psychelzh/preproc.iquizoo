test_that("Works without grouping variables", {
  withr::local_seed(1)
  data <- tibble(numdist = c(0, 2)) |>
    mutate(
      data = purrr::map(
        numdist,
        ~ tibble(
          acc = sample(c(0, 1), 20, replace = TRUE, prob = c(0.3, 0.7)),
          numtarget = prepare_level(
            acc, 2, 1,
            level_init = 4,
            level_limits = c(2, 10)
          )
        )
      )
    ) |>
    unnest(data)
  condstairs(data) |>
    expect_silent() |>
    expect_snapshot_value(style = "json2")
})

test_that("Works with grouping variables", {
  withr::local_seed(1)
  data <- expand_grid(
    id = 1:2,
    tibble(numdist = c(0, 2)) |>
      mutate(
        data = purrr::map(
          numdist,
          ~ tibble(
            acc = sample(c(0, 1), 20, replace = TRUE, prob = c(0.3, 0.7)),
            numtarget = prepare_level(
              acc, 2, 1,
              level_init = 4,
              level_limits = c(2, 10)
            )
          )
        )
      ) |>
      unnest(data)
  )
  condstairs(data, .by = "id") |>
    expect_silent() |>
    expect_snapshot_value(style = "json2")
})
