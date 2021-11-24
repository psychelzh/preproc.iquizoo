set.seed(1)
n_subject <- 100
data <- tibble::tibble(
  id = seq_len(n_subject),
  n = 14
) |>
  uncount(n, .id = "Trial") |>
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
                sample(c(0, 1), slen, replace = TRUE)
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
  expect_snapshot(preproc(data, span, .by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, span, .by = c("id", "id1")))
})

test_that("Works when no acc column found", {
  data_no_acc <- tibble::tibble(
    id = seq_len(n_subject),
    n = 14
  ) |>
    uncount(n, .id = "Trial") |>
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
  result_no_acc <- preproc(data_no_acc, span, .by = "id")
  expect_snapshot(result_no_acc)
  expect_true(all(is.na(result_no_acc$nc)))
  data_repairable <- data_no_acc |>
    mutate(
      stim = purrr::map_chr(
        slen, ~ paste(seq_len(.x), collapse = "-")
      ),
      resp = purrr::map_chr(
        slen, ~ paste(sample(seq_len(.x)), collapse = "-")
      )
    )
  result_repaired <- preproc(data_repairable, span, .by = "id")
  expect_snapshot(result_repaired)
  expect_true(all(!is.na(result_repaired$nc)))
})
