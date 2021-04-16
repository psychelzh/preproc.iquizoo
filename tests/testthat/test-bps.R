# prepare data
set.seed(1)
data <- tidyr::expand_grid(
  id = 1:1000,
  tibble(
    phase = c("Learn", "Test"),
    n = c(40, 60)
  )
) %>%
  tidyr::uncount(n, .id = "trial") %>%
  dplyr::mutate(
    type = dplyr::case_when(
      phase == "Learn" ~ NA_character_,
      (trial + 1) %% 3 == 0 ~ "lure",
      (trial + 1) %% 3 == 1 ~ "foil",
      (trial + 1) %% 3 == 2 ~ "target"
    ),
    resp = dplyr::if_else(
      phase == "Learn",
      sample(c("Left", "Right"), dplyr::n(), replace = TRUE),
      sample(c("Old", "Similar", "New"), dplyr::n(), replace = TRUE)
    ),
    acc = dplyr::case_when(
      phase == "Learn" ~ NA_integer_,
      (type == "target" & resp == "Old") |
        (type == "foil" & resp == "New") |
        (type == "lure" & resp == "Similar") ~ 1L,
      TRUE ~ 0L
    ),
    rt = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, bps, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, bps, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data %>%
    dplyr::mutate(
      phase = dplyr::recode(phase, Learn = "learn"),
      type = dplyr::recode(type, foil = "Foil"),
      resp = dplyr::recode(resp, New = "new")
    )
  expect_silent(
    case_messy <- preproc_data(data_case_messy, bps, by = "id")
  )
  expect_identical(
    case_messy,
    preproc_data(data, bps, by = "id")
  )
})
