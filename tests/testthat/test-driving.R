set.seed(1)
n_subject <- 5
data <- expand_grid(
  id = seq_len(n_subject),
  yellowdur = runif(8, 3000, 15000)
) |>
  mutate(
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
# some rare cases produce negative durations by error
data_negtive_dur <- tibble::tibble(
  id = 1,
  yellowdur = runif(8, 3000, 15000)
) |>
  mutate(
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


test_that("Default behavior works", {
  expect_snapshot_value(
    driving(data),
    style = "json2"
  )
})

test_that("Works with grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    driving(data, .by = "id"),
    style = "json2"
  )
})

test_that("No error for negative duration case (but produces `NA`s)", {
  anyNA(driving(data_negtive_dur)) |>
    expect_silent() |>
    expect_true()
})
