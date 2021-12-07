set.seed(1)
n_subject <- 5
data <- tibble::tibble(
  id = seq_len(n_subject),
  n = 300
) |>
  uncount(n) |>
  mutate(
    type = sample(
      c("random", "aonly", "bonly", "target"),
      n(),
      replace = TRUE
    ),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )
data_perfect <- tibble::tibble(
  id = rep(1, 10),
  type = sample(
    c("random", "aonly", "bonly", "target"),
    10,
    replace = TRUE
  ),
  acc = 1,
  rt = rexp(10, 0.001)
)
data_dualtask <- tibble::tibble(
  id = seq_len(n_subject),
  n = 300
) |>
  uncount(n) |>
  mutate(
    stimtype = sample(
      c("nontarget", "target"),
      n(),
      replace = TRUE
    ),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    cpt(data),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Default behavior works for Dual Task Paradigm", {
  expect_snapshot_value(
    cpt(data_dualtask, .input = list(name_type = "stimtype")),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Default behavior works for Cancellation Paradigm", {
  data <- tibble::tibble(
    id = seq_len(n_subject),
    n = 300
  ) |>
    uncount(n) |>
    mutate(
      cresp = sample(
        c("left", "right"),
        n(),
        replace = TRUE
      ),
      acc = sample(-1:1, n(), replace = TRUE),
      rt = rexp(n(), 0.001)
    )
  data_clean <- data |>
    filter(acc != -1)
  expect_snapshot_value(
    cpt(
      data,
      .input = list(name_type = "cresp"),
      .extra = list(type_signal = "left")
    ),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works on perfect accuracy data (no `NA`s)", {
  anyNA(cpt(data_perfect)) |>
    expect_silent() |>
    expect_false()
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    cpt(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
