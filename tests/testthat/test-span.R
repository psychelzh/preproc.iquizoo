#' Utility function for level (or something similar) data preparation
.prepare_level <- function(outcome, init_level, max_level, min_level) {
  out <- numeric(length(outcome))
  for (i in seq_along(outcome)) {
    if (i == 1) {
      out[i] <- init_level
    } else {
      if (outcome[i - 1] == 1) {
        out[i] <- min(max_level, out[i - 1] + 1)
      } else {
        out[i] <- max(min_level, out[i - 1] - 1)
      }
    }
  }
  out
}

data <- withr::with_seed(
  1,
  tibble(trial = 1:14) |>
    mutate(
      outcome = sample(
        c(0, 1),
        n(),
        replace = TRUE,
        prob = c(0.2, 0.8)
      ),
      slen = .prepare_level(
        outcome,
        init_level = 3,
        max_level = 16,
        min_level = 2
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
    span(data),
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
        slen = .prepare_level(
          outcome,
          init_level = 3,
          max_level = 16,
          min_level = 2
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
