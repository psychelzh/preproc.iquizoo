data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    tibble::tibble(
      phase = c("learn", "test"),
      n = c(40, 60)
    )
  ) |>
    uncount(n, .id = "trial") |>
    mutate(
      type = case_when(
        phase == "learn" ~ NA_character_,
        (trial + 1) %% 3 == 0 ~ "lure",
        (trial + 1) %% 3 == 1 ~ "foil",
        (trial + 1) %% 3 == 2 ~ "target"
      ),
      resp = if_else(
        phase == "learn",
        sample(c("left", "right"), n(), replace = TRUE),
        sample(c("old", "similar", "new"), n(), replace = TRUE)
      ),
      acc = case_when(
        phase == "learn" ~ NA_integer_,
        (type == "target" & resp == "old") |
          (type == "foil" & resp == "new") |
          (type == "lure" & resp == "similar") ~ 1L,
        TRUE ~ 0L
      ),
      rt = rexp(n(), 0.001)
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    bps(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(bps(data, .by = "id"), style = "json2")
})
