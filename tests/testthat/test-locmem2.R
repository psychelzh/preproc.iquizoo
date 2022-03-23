test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble(trial = 1:10) |>
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
  )
  expect_snapshot_value(
    locmem2(data),
    style = "json2"
  )
})
