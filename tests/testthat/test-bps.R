# prepare data
set.seed(1)
data <- expand_grid(
  id = 1:1000,
  tibble::tibble(
    phase = c("Learn", "Test"),
    n = c(40, 60)
  )
) |>
  uncount(n, .id = "trial") |>
  mutate(
    type = case_when(
      phase == "Learn" ~ NA_character_,
      (trial + 1) %% 3 == 0 ~ "lure",
      (trial + 1) %% 3 == 1 ~ "foil",
      (trial + 1) %% 3 == 2 ~ "target"
    ),
    resp = if_else(
      phase == "Learn",
      sample(c("Left", "Right"), n(), replace = TRUE),
      sample(c("Old", "Similar", "New"), n(), replace = TRUE)
    ),
    acc = case_when(
      phase == "Learn" ~ NA_integer_,
      (type == "target" & resp == "Old") |
        (type == "foil" & resp == "New") |
        (type == "lure" & resp == "Similar") ~ 1L,
      TRUE ~ 0L
    ),
    rt = rexp(n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc(data, bps, .by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, bps, .by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data |>
    mutate(
      phase = recode(phase, Learn = "learn"),
      type = recode(type, foil = "Foil"),
      resp = recode(resp, New = "new")
    )
  expect_silent(
    case_messy <- preproc(data_case_messy, bps, .by = "id")
  )
  expect_identical(
    case_messy,
    preproc(data, bps, .by = "id")
  )
})
