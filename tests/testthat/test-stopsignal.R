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
n_users <- 5
data <- expand_grid(
  id = seq_len(n_users),
  tibble::tibble(
    trial = seq_len(160),
    type = sample(
      c(
        rep("go", 120),
        rep("stop1", 20),
        rep("stop2", 20)
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
    rt = ifelse(acc == 1 & type != "go", 0, rexp(n(), 0.001))
  ) |>
  arrange(id, trial)

test_that("Default behavior works", {
  expect_snapshot_value(
    stopsignal(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    stopsignal(data, .by = c("id", "id1")),
    style = "json2"
  )
})
