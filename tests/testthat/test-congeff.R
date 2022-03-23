test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble(trial = 1:20) |>
      mutate(
        type = sample(
          c("incongruent", "congruent"),
          n(),
          replace = TRUE
        ),
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    congeff(data),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works when condition missing", {
  data_miss_cond <- withr::with_seed(
    1,
    tibble::tibble(
      trial = 1:100,
      type = "incongruent"
    ) |>
      mutate(
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    congeff(data_miss_cond),
    style = "json2",
    tolerance = 1e-5
  )
})
