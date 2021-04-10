set.seed(1)
n_subject <- 100
data <- tibble(
  id = seq_len(n_subject),
  n = 14
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(
    Outcome = sample(
      c(0, 1),
      dplyr::n(),
      replace = TRUE,
      prob = c(0.2, 0.8)
    )
  ) %>%
  dplyr::group_by(id) %>%
  dplyr::group_modify(
    ~ .x %>%
      dplyr::mutate(
        SLen = .prepare_level(
          Outcome,
          init_level = 3,
          max_level = 16,
          min_level = 2
        )
      ) %>%
      dplyr::rowwise() %>%
      dplyr::mutate(
        Correctness = ifelse(
          Outcome == 1,
          stringr::str_c(rep(1, SLen), collapse = "-"),
          stringr::str_c(
            sample(
              c(
                0,
                sample(c(0, 1), SLen, replace = TRUE)
              )
            ),
            collapse = "-"
          )
        )
      ) %>%
      dplyr::ungroup()
  ) %>%
  dplyr::ungroup()
data_no_acc <- tibble(
  id = seq_len(n_subject),
  n = 14
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(
    Outcome = sample(
      c(0, 1),
      dplyr::n(),
      replace = TRUE,
      prob = c(0.2, 0.8)
    )
  ) %>%
  dplyr::group_by(id) %>%
  dplyr::group_modify(
    ~ .x %>%
      dplyr::mutate(
        SLen = .prepare_level(
          Outcome,
          init_level = 3,
          max_level = 16,
          min_level = 2
        )
      )
  ) %>%
  dplyr::ungroup()

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, span, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, span, by = c("id", "id1")))
})

test_that("Works when no acc column found", {
  expect_snapshot(preproc_data(data_no_acc, span, by = "id"))
})
