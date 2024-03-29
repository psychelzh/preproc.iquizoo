n_subject <- 2
data <- withr::with_seed(
  1,
  expand_grid(
    id = seq_len(n_subject),
    tibble::tribble(
      ~type, ~n,
      "filler", 10,
      "foil", 30,
      "lure", 30,
      "old", 30
    )
  ) |>
    uncount(n) |>
    mutate(
      resp = sample(c("new", "old"), n(), replace = TRUE),
      acc = ifelse(
        (type == "old" & resp == "old") |
          (type %in% c("foil", "lure") & resp == "new"),
        1, 0
      ),
      rt = rexp(n(), 0.001)
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    drm(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    drm(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
