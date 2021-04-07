set.seed(1)
n_subject <- 100
data <- tidyr::expand_grid(
  id = seq_len(n_subject),
  Angle = sample(c(6:9, -(6:9)) * 6)
) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    resp_base = list(sample(c(-1, 1), sample(1:100, 1), replace = TRUE)),
    Resp = dplyr::recode(resp_base, `1` = "Left", `-1` = "Right") %>%
      stringr::str_c(collapse = "-"),
    resp_angle = sum(resp_base) * 6,
    resp_err = abs(resp_angle - Angle) %% 360,
    ACC = ifelse(resp_err %in% c(0, 180), 1, 0)
  ) %>%
  dplyr::ungroup() %>%
  dplyr::select(-dplyr::contains("_"))

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, jlo))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, jlo, by = c("id", "id1")))
})
