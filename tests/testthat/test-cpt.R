set.seed(1)
n_subject <- 100
data <- tibble(
  id = seq_len(n_subject),
  n = 300
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(
    Type = sample(
      c("Random", "Aonly", "Bonly", "Target"),
      dplyr::n(), replace = TRUE
    ),
    ACC = sample(c(0, 1), dplyr::n(), replace = TRUE),
    RT = rexp(dplyr::n(), 0.001)
  )
data_perfect <- tibble(
  id = rep(1, 10),
  Type = sample(
    c("Random", "Aonly", "Bonly", "Target"),
    10, replace = TRUE
  ),
  ACC = 1,
  RT = rexp(10, 0.001)
)
data_dualtask <- tibble(
  id = seq_len(n_subject),
  n = 300
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(
    StimType = sample(
      c("NonTarget", "Target"),
      dplyr::n(), replace = TRUE
    ),
    ACC = sample(c(0, 1), dplyr::n(), replace = TRUE),
    RT = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, cpt))
})

test_that("Default behavior works for Dual Task Paradigm", {
  expect_snapshot(preproc_data(data_dualtask, cpt))
})

test_that("Works on perfect accuracy data (no `NA`s)", {
  expect_snapshot(preproc_data(data_perfect, cpt))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, cpt, by = c("id", "id1")))
})
