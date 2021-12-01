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
    cpt(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Default behavior works for Dual Task Paradigm", {
  with_options(
    expect_snapshot_value(
      cpt(data_dualtask, .by = "id"),
      style = "json2",
      tolerance = 1e-5
    ),
    preproc.input = list(name_type = "stimtype")
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
  with_options(
    {
      expect_snapshot_value(
        cpt(data, .by = "id"),
        style = "json2",
        tolerance = 1e-5
      )
      expect_identical(
        cpt(data, .by = "id"),
        cpt(data_clean, .by = "id")
      )
    },
    preproc.input = list(name_type = "cresp"),
    preproc.extra = list(type_signal = "left")
  )
})

test_that("Works on perfect accuracy data (no `NA`s)", {
  anyNA(cpt(data_perfect, .by = "id")) |>
    expect_silent() |>
    expect_false()
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    cpt(data, .by = c("id", "id1")),
    style = "json2",
    tolerance = 1e-5
  )
})
