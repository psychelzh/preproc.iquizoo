data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    block = 1:3,
    trial = 1:20
  ) |>
    mutate(
      acc = sample(c(0, 1), n(), replace = TRUE, prob = c(0.2, 0.8)),
      level = prepare_level(
        acc, 3, 1,
        level_init = 150,
        level_step = -5,
        level_limits = c(5, Inf)
      ),
      .by = id
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    staircase(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    staircase(data, .by = "id"),
    style = "json2"
  )
})
