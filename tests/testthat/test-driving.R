data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    trial = 1:8
  ) |>
    mutate(
      yellowdur = runif(n(), 3000, 15000),
      stilldurlist = purrr::map(
        yellowdur,
        ~ {
          repeat {
            n <- sample(1:10, 1)
            dur <- rexp(n, 0.001)
            if (sum(dur) < .x) break
          }
          round(dur)
        }
      ),
      stilldur = purrr::map_chr(
        stilldurlist,
        ~ stringr::str_c(.x, collapse = "-")
      ),
      stilllight = purrr::map_chr(
        stilldurlist,
        ~ sample(c("yellow", "green"), length(.x), replace = TRUE) |>
          stringr::str_c(collapse = "-")
      )
    ) |>
    select(-stilldurlist)
)

test_that("Default behavior works", {
  expect_snapshot_value(
    driving(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    driving(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("No error for negative duration case (but produces `NA`s)", {
  # some rare cases produce negative durations by error
  data_negtive_dur <- withr::with_seed(
    1,
    tibble(trial = 1:8) |>
      mutate(
        yellowdur = runif(n(), 3000, 15000),
        stilldurlist = purrr::map(
          yellowdur,
          ~ {
            repeat {
              n <- sample(1:10, 1)
              dur <- runif(n, -500, 1000)
              if (sum(dur) < .x) break
            }
            round(dur)
          }
        ),
        stilldur = purrr::map_chr(
          stilldurlist,
          ~ stringr::str_c(.x, collapse = "-")
        ),
        stilllight = purrr::map_chr(
          stilldurlist,
          ~ sample(c("yellow", "green"), length(.x), replace = TRUE) |>
            stringr::str_c(collapse = "-")
        )
      ) |>
      select(-stilldurlist)
  )
  driving(data_negtive_dur) |>
    expect_silent() |>
    expect_snapshot_value(style = "json2")
})
