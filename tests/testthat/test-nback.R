set.seed(1)
data <- expand_grid(
  id = seq_len(100),
  tibble::tibble(
    type = c("None", "Change", "Stay"),
    n = c(1, 10, 10)
  )
) |>
  uncount(n) |>
  mutate(
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc(data, nback, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, nback, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data |>
    mutate(
      type = recode(type, Change = "change")
    )
  expect_silent(
    case_messy <- preproc(data_case_messy, nback, by = "id")
  )
  expect_identical(
    case_messy,
    preproc(data, nback, by = "id")
  )
})

test_that("Works when using `'filler'` or `'target'`", {
  data_new_value <- data |>
    mutate(
      type = recode(type, Change = "target", None = "filler")
    )
  expect_silent(
    new_value <- preproc(data_new_value, nback, by = "id")
  )
  expect_identical(
    new_value,
    preproc(data, nback, by = "id")
  )
})
