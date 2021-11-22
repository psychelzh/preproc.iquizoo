.prepare_ssd <- function(acc, type) {
  if (type == "Go") {
    return(0)
  }
  ssd_init <- ifelse(type == "Stop1", 250, 500)
  ssd <- numeric(length(acc))
  for (i in seq_along(acc)) {
    if (i == 1) {
      ssd[i] <- ssd_init
    } else {
      if (acc[i - 1] == 1) {
        ssd[i] <- max(150, ssd[i - 1] - 50)
      } else {
        ssd[i] <- min(800, ssd[i - 1] + 50)
      }
    }
  }
  ssd
}

set.seed(1)
data <- expand_grid(
  id = seq_len(100),
  tibble::tibble(
    trial = seq_len(160),
    type = sample(
      c(
        rep("Go", 120),
        rep("Stop1", 20),
        rep("Stop2", 20)
      )
    )
  )
) |>
  mutate(acc = sample(c(0, 1), n(), replace = TRUE)) |>
  group_by(id, type) |>
  group_modify(
    ~ .x |>
      mutate(
        ssd = .prepare_ssd(
          acc, .y$type
        )
      )
  ) |>
  ungroup() |>
  mutate(
    rt = ifelse(acc == 1 & type != "Go", 0, rexp(n(), 0.001))
  ) |>
  arrange(id, trial)

test_that("Default behavior works", {
  expect_snapshot(preproc(data, stopsignal, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, stopsignal, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data |>
    mutate(
      type = recode(type, Stop1 = "stop1")
    )
  expect_silent(
    case_messy <- preproc(data_case_messy, stopsignal, by = "id")
  )
  expect_identical(
    case_messy,
    preproc(data, stopsignal, by = "id")
  )
})
