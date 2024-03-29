.prepare_ssd <- function(acc, type) {
  if (type == "go") {
    return(0)
  }
  ssd_init <- ifelse(type == "stop1", 250, 500)
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
data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    tibble(
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
    mutate(
      acc = ifelse(
        type == "go",
        sample(
          c(-1, 0, 1), n(),
          prob = c(0.05, 0.25, 0.7),
          replace = TRUE
        ),
        sample(
          c(0, 1), n(),
          replace = TRUE
        )
      )
    ) |>
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
      rt = ifelse(
        (acc == 1 & type != "go") | (acc == -1 & type == "go"),
        0, runif(n(), 150, 1000)
      )
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    stopsignal(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    stopsignal(data, .by = "id"),
    style = "json2"
  )
})
