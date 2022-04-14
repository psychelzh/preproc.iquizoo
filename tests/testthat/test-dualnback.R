test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    expand_grid(
      dual = c("aud", "vis"),
      tibble::tibble(
        type = c("filler", "same", "different"),
        n = c(1, 10, 10)
      )
    ) |>
      uncount(n) |>
      group_by(dual) |>
      mutate(trial = row_number()) |>
      ungroup() |>
      mutate(
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = if_else(
          type == "filler" | xor(type == "same", acc == 1),
          0, rexp(n(), 0.001)
        )
      ) |>
      pivot_wider(
        names_from = dual,
        values_from = c(type, acc, rt),
        names_sep = ""
      )
  )
  expect_snapshot_value(
    dualnback(data),
    style = "json2",
    tolerance = 1e-5
  )
})
