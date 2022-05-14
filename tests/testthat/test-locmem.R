data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    trial = 1:10
  ) |>
    rowwise() |>
    mutate(
      resplocdist = runif(sample.int(10, 1), 0, 10) |>
        round(2) |>
        stringr::str_c(collapse = "-")
    ) |>
    ungroup()
)

test_that("Default behavior works", {
  expect_snapshot_value(
    locmem(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    locmem(data, .by = "id"),
    style = "json2"
  )
})
