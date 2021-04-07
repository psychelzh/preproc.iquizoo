# prepare data
set.seed(1)
data <- tidyr::expand_grid(
  id = 1:1000,
  tibble(
    Phase = c("Learn", "Test"),
    n = c(40, 60)
  )
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(
    Type = dplyr::case_when(
      Phase == "Learn" ~ NA_character_,
      (Trial + 1) %% 3 == 0 ~ "lure",
      (Trial + 1) %% 3 == 1 ~ "foil",
      (Trial + 1) %% 3 == 2 ~ "target"
    ),
    Resp = dplyr::if_else(
      Phase == "Learn",
      sample(c("Left", "Right"), dplyr::n(), replace = TRUE),
      sample(c("Old", "Similar", "New"), dplyr::n(), replace = TRUE)
    ),
    ACC = dplyr::case_when(
      Phase == "Learn" ~ NA_integer_,
      (Type == "target" & Resp == "Old") |
        (Type == "foil" & Resp == "New") |
        (Type == "lure" & Resp == "Similar") ~ 1L,
      TRUE ~ 0L
    ),
    RT = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, bps))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, bps, by = c("id", "id1")))
})
