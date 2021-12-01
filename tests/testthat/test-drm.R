set.seed(1)
n_subject <- 5
data <- expand_grid(
  id = seq_len(n_subject),
  tibble::tribble(
    ~type, ~n,
    "filler", 10,
    "foil", 30,
    "lure", 30,
    "old", 30
  ) |>
    uncount(n)
) |>
  mutate(
    resp = sample(c("new", "old"), n(), replace = TRUE),
    acc = ifelse(
      (type == "old" & resp == "old") |
        (type %in% c("foil", "lure") & resp == "new"),
      1, 0
    ),
    rt = rexp(n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    drm(data),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    drm(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
