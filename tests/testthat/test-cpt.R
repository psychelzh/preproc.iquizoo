set.seed(1)
n_subject <- 100
data <- tibble::tibble(
  id = seq_len(n_subject),
  n = 300
) %>%
  uncount(n) %>%
  mutate(
    type = sample(
      c("Random", "Aonly", "Bonly", "Target"),
      n(),
      replace = TRUE
    ),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )
data_perfect <- tibble::tibble(
  id = rep(1, 10),
  type = sample(
    c("Random", "Aonly", "Bonly", "Target"),
    10,
    replace = TRUE
  ),
  acc = 1,
  rt = rexp(10, 0.001)
)
data_dualtask <- tibble::tibble(
  id = seq_len(n_subject),
  n = 300
) %>%
  uncount(n) %>%
  mutate(
    stimtype = sample(
      c("NonTarget", "Target"),
      n(),
      replace = TRUE
    ),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, cpt, by = "id"))
})

test_that("Default behavior works for Dual Task Paradigm", {
  expect_snapshot(preproc_data(data_dualtask, cpt, by = "id"))
})

test_that("Default behavior works for Cancellation Paradigm", {
  data <- tibble::tibble(
    id = seq_len(n_subject),
    n = 300
  ) %>%
    uncount(n) %>%
    mutate(
      cresp = sample(
        c("Left", "Right"),
        n(),
        replace = TRUE
      ),
      acc = sample(-1:1, n(), replace = TRUE),
      rt = rexp(n(), 0.001)
    )
  data_clean <- data %>%
    filter(acc != -1)
  expect_snapshot(preproc_data(data, cpt, by = "id"))
  expect_identical(
    preproc_data(data, cpt, by = "id"),
    preproc_data(data_clean, cpt, by = "id")
  )
})

test_that("Works on perfect accuracy data (no `NA`s)", {
  expect_snapshot(preproc_data(data_perfect, cpt, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, cpt, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data %>%
    mutate(
      type = recode(type, Target = "target")
    )
  expect_silent(
    case_messy <- preproc_data(data_case_messy, cpt, by = "id")
  )
  expect_identical(
    case_messy,
    preproc_data(data, cpt, by = "id")
  )
})
