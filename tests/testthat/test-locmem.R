set.seed(1)
data <- tibble::tibble(
  id = rep(1:100, each = 10)
) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    resplocdist = runif(sample.int(10, 1), 0, 10) %>%
      round(2) %>%
      stringr::str_c(collapse = "-")
  ) %>%
  dplyr::ungroup()

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, locmem, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, locmem, by = c("id", "id1")))
})
