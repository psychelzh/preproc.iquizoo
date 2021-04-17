set.seed(1)
n_subject <- 100
data <- tidyr::expand_grid(
  id = seq_len(n_subject),
  yellowdur = runif(8, 3000, 15000)
) %>%
  dplyr::mutate(
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
      ~ sample(c("Yellow", "Green"), length(.x), replace = TRUE) %>%
        stringr::str_c(collapse = "-")
    )
  ) %>%
  dplyr::select(-stilldurlist)
# some rare cases produce negative durations by error
data_negtive_dur <- tibble::tibble(
  id = 1,
  yellowdur = runif(8, 3000, 15000)
) %>%
  dplyr::mutate(
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
      ~ sample(c("Yellow", "Green"), length(.x), replace = TRUE) %>%
        stringr::str_c(collapse = "-")
    )
  ) %>%
  dplyr::select(-stilldurlist)


test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, driving, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, driving, by = c("id", "id1")))
})

test_that("No error for negative duration case (but produces `NA`s)", {
  expect_snapshot(preproc_data(data_negtive_dur, driving, by = "id"))
})

test_that("Works when character case is messy", {
  data_case_messy <- data %>%
    dplyr::mutate(
      stilllight = dplyr::recode(stilllight, Green = "green")
    )
  expect_silent(
    case_messy <- preproc_data(data_case_messy, driving, by = "id")
  )
  expect_identical(
    case_messy,
    preproc_data(data, driving, by = "id")
  )
})
