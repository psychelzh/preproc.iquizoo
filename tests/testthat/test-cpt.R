n_subject <- 2
data <- withr::with_seed(
  1,
  expand_grid(
    id = seq_len(n_subject),
    trial = 1:20
  ) |>
    mutate(
      type = sample(
        c("nontarget", "target"),
        n(),
        replace = TRUE
      ),
      acc = sample(c(0, 1), n(), replace = TRUE, prob = c(0.1, 0.9)),
      rt = rexp(n(), 0.001)
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    cpt(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    cpt(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works on perfect accuracy data (no `NA`s)", {
  data_perfect <- withr::with_seed(
    1,
    tibble(trial = 1:20) |>
      mutate(
        type = sample(
          c("nontarget", "target"),
          n(),
          replace = TRUE
        ),
        acc = 1,
        rt = rexp(n(), 0.001)
      )
  )
  cpt(data_perfect) |>
    expect_silent() |>
    expect_snapshot_value(style = "json2")
})
