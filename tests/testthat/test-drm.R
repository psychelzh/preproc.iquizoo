set.seed(1)
n_subject <- 100
data <- tidyr::expand_grid(
  id = seq_len(n_subject),
  tibble::tribble(
    ~type, ~n,
    "Filler", 10,
    "Foil", 30,
    "Lure", 30,
    "Old", 30
  ) %>%
    tidyr::uncount(n)
) %>%
  dplyr::mutate(
    resp = sample(c("New", "Old"), dplyr::n(), replace = TRUE),
    acc = ifelse(
      (type == "Old" & resp == "Old") |
        (type %in% c("Foil", "Lure") & resp == "New"),
      1, 0
    ),
    rt = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, drm, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, drm, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data %>%
    dplyr::mutate(
      resp = dplyr::recode(resp, New = "new"),
      type = dplyr::recode(type, Old = "old")
    )
  expect_silent(
    case_messy <- preproc_data(data_case_messy, drm, by = "id")
  )
  expect_identical(
    case_messy,
    preproc_data(data, drm, by = "id")
  )
})
