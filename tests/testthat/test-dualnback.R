data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    dual = c("aud", "vis"),
    tibble::tibble(
      type = c("filler", "same", "different"),
      n = c(1, 10, 10)
    )
  ) |>
    uncount(n) |>
    mutate(trial = row_number(), .by = c(id, dual)) |>
    mutate(
      acc = sample(c(0, 1), n(), replace = TRUE),
      rt = if_else(
        type == "filler" | xor(type == "same", acc == 1),
        0, rexp(n(), 0.001)
      )
    ) |>
    pivot_wider(
      names_from = dual,
      values_from = c(type, acc, rt),
      names_sep = ""
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    dualnback(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    dualnback(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
