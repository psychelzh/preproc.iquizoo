set.seed(1)
data <- expand_grid(
  id = seq_len(100),
  tibble::tibble(
    type = c("Image", "Sound", "Mixed"),
    n = 20
  )
) |>
  uncount(n) |>
  mutate(rt = rexp(n(), 0.001))

test_that("Default behavior works", {
  expect_snapshot(preproc(data, multisense, .by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, multisense, .by = c("id", "id1")))
})


test_that("Works when character case is messy", {
  data_case_messy <- data |>
    mutate(
      type = recode(type, Image = "image")
    )
  expect_silent(
    case_messy <- preproc(data_case_messy, multisense, .by = "id")
  )
  expect_identical(
    case_messy,
    preproc(data, multisense, .by = "id")
  )
})
