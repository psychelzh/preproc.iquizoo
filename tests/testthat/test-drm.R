set.seed(1)
n_subject <- 100
data <- tidyr::expand_grid(
  id = seq_len(n_subject),
  tibble::tribble(
    ~Type, ~n,
    "Filler", 10,
    "Foil", 30,
    "Lure", 30,
    "Old", 30
  ) %>%
    tidyr::uncount(n, .id = "Trial")
) %>%
  dplyr::mutate(
    Resp = sample(c("New", "Old"), dplyr::n(), replace = TRUE),
    ACC = ifelse(
      (Type == "Old" & Resp == "Old") |
        (Type %in% c("Foil", "Lure") & Resp == "New"),
      1, 0
    ),
    RT = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, drm, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, drm, by = c("id", "id1")))
})
