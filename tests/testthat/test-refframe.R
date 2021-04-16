set.seed(1)
data <- tidyr::expand_grid(
  id = seq_len(100),
  tibble(
    type = c("Allocentric", "Egocentric"),
    n = 15
  )
) %>%
  tidyr::uncount(n) %>%
  dplyr::mutate(dist = runif(dplyr::n(), 0, 200))

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, refframe, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, refframe, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data %>%
    dplyr::mutate(
      type = dplyr::recode(type, Allocentric = "allocentric")
    )
  expect_silent(
    case_messy <- preproc_data(data_case_messy, refframe, by = "id")
  )
  expect_identical(
    case_messy,
    preproc_data(data, refframe, by = "id")
  )
})
