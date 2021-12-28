set.seed(1)
n_subject <- 5
data <- tibble::tibble(
  id = seq_len(n_subject),
  n = 14
) |>
  uncount(n, .id = "trial") |>
  mutate(
    outcome = sample(
      c(0, 1),
      n(),
      replace = TRUE,
      prob = c(0.2, 0.8)
    )
  ) |>
  group_by(id) |>
  group_modify(
    ~ .x |>
      mutate(
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
            sample(
              c(
                0,
                sample(c(0, 1), slen - 1, replace = TRUE)
              )
            ),
            collapse = "-"
          )
        )
      ) |>
      ungroup()
  ) |>
  ungroup()

test_that("Default behavior works", {
  expect_snapshot_value(
    span(data),
    style = "json2"
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    span(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works when no acc column found", {
  data_no_acc <- tibble::tibble(
    id = seq_len(n_subject),
    n = 14
  ) |>
    uncount(n, .id = "trial") |>
    mutate(
      outcome = sample(
        c(0, 1),
        n(),
        replace = TRUE,
        prob = c(0.2, 0.8)
      )
    ) |>
    group_by(id) |>
    group_modify(
      ~ .x |>
        mutate(
          slen = .prepare_level(
            outcome,
            init_level = 3,
            max_level = 16,
            min_level = 2
          )
        )
    ) |>
    ungroup()
  result_no_acc <- span(data_no_acc, .by = "id")
  expect_snapshot_value(result_no_acc, style = "json2")
  data_repairable <- data_no_acc |>
    mutate(
      stim = purrr::map_chr(
        slen, ~ paste(seq_len(.x), collapse = "-")
      ),
      resp = purrr::map_chr(
        slen, ~ paste(sample(seq_len(.x)), collapse = "-")
      )
    )
  result_repaired <- span(data_repairable, .by = "id")
  expect_snapshot_value(result_repaired, style = "json2")
})
