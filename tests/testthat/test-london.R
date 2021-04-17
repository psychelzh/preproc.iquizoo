set.seed(1)
n_subject <- 100
data <- tibble::tibble(
  id = seq_len(n_subject),
  n = 14
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(
    outcome = sample(c(0, 1), dplyr::n(), replace = TRUE, prob = c(0.2, 0.8))
  ) %>%
  dplyr::group_by(id) %>%
  dplyr::group_modify(
    ~ .x %>%
      dplyr::mutate(
        level = .prepare_level(
          outcome,
          init_level = 3,
          max_level = 8,
          min_level = 2
        ),
        score = ifelse(outcome == 1, level * 100, 0) +
          round(runif(dplyr::n(), max = level * 100)),
        stepsused = ifelse(outcome == 1, level, 0) +
          sample(0:20, dplyr::n(), replace = TRUE)
      )
  ) %>%
  dplyr::ungroup()

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, london, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, london, by = c("id", "id1")))
})
