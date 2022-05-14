data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    angle = sample(c(6:9, -(6:9)) * 6)
  ) |>
    rowwise() |>
    mutate(
      resp_base = list(sample(c(-1, 1), sample(1:100, 1), replace = TRUE)),
      resp = recode(resp_base, `1` = "left", `-1` = "right") |>
        stringr::str_c(collapse = "-"),
      resp_angle = sum(resp_base) * 6,
      resp_err = abs(resp_angle - angle) %% 360,
      acc = ifelse(resp_err %in% c(0, 180), 1, 0)
    ) |>
    ungroup() |>
    select(-contains("_"))
)

test_that("Default behavior works", {
  expect_snapshot_value(
    jlo(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    jlo(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

