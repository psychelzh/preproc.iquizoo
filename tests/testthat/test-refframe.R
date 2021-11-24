set.seed(1)
data <- expand_grid(
  id = seq_len(100),
  tibble::tibble(
    type = c("Allocentric", "Egocentric"),
    n = 15
  )
) |>
  uncount(n) |>
  mutate(dist = runif(n(), 0, 200))

test_that("Default behavior works", {
  expect_snapshot(preproc(data, refframe, .by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, refframe, .by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data |>
    mutate(
      type = recode(type, Allocentric = "allocentric")
    )
  expect_silent(
    case_messy <- preproc(data_case_messy, refframe, .by = "id")
  )
  expect_identical(
    case_messy,
    preproc(data, refframe, .by = "id")
  )
})
