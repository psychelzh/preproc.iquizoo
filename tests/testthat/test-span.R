set.seed(1)
n_subject <- 100
data <- tibble::tibble(
  id = seq_len(n_subject),
  n = 14
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(
    outcome = sample(
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
        slen = .prepare_level(
          outcome,
          init_level = 3,
          max_level = 16,
          min_level = 2
        )
      ) %>%
      dplyr::rowwise() %>%
      dplyr::mutate(
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
      ) %>%
      dplyr::ungroup()
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
  data_no_acc <- tibble::tibble(
    id = seq_len(n_subject),
    n = 14
  ) %>%
    tidyr::uncount(n, .id = "Trial") %>%
    dplyr::mutate(
      outcome = sample(
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
          slen = .prepare_level(
            outcome,
            init_level = 3,
            max_level = 16,
            min_level = 2
          )
        )
    ) %>%
    dplyr::ungroup()
  result_no_acc <- preproc_data(data_no_acc, span, by = "id")
  expect_snapshot(result_no_acc)
  expect_true(all(is.na(result_no_acc$nc)))
  data_repairable <- data_no_acc %>%
    dplyr::mutate(
      stim = purrr::map_chr(
        slen, ~ paste(seq_len(.x), collapse = "-")
      ),
      resp = purrr::map_chr(
        slen, ~ paste(sample(seq_len(.x)), collapse = "-")
      )
    )
  result_repaired <- preproc_data(data_repairable, span, by = "id")
  expect_snapshot(result_repaired)
  expect_true(all(!is.na(result_repaired$nc)))
})
