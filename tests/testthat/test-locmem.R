set.seed(1)
n_users <- 5
data <- tibble::tibble(id = rep(1:n_users, each = 10)) |>
  rowwise() |>
  mutate(
    resplocdist = runif(sample.int(10, 1), 0, 10) |>
      round(2) |>
      stringr::str_c(collapse = "-")
  ) |>
  ungroup()

test_that("Default behavior works", {
  expect_snapshot_value(
    locmem(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    locmem(data, .by = c("id", "id1")),
    style = "json2"
  )
})
