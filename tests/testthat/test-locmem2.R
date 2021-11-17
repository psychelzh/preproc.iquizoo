set.seed(1)
data <- tibble::tibble(
  id = rep(1:100, each = 10)
) |>
  rowwise() |>
  mutate(
    n_obj = sample.int(10, 1),
    resplocdist = runif(n_obj, 0, 10) |>
      round(2) |>
      stringr::str_c(collapse = "-"),
    respaccorder = sample(c(0, 1), n_obj, replace = TRUE) |>
      stringr::str_c(collapse = "-")
  ) |>
  ungroup()

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, locmem2, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, locmem2, by = c("id", "id1")))
})
