.prepare_ssd <- function(acc, type) {
  if (type == "Go") return(0)
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
data <- tidyr::expand_grid(
  id = seq_len(100),
  tibble(
    Trial = seq_len(160),
    Type = sample(
      c(
        rep("Go", 120),
        rep("Stop1", 20),
        rep("Stop2", 20)
      )
    )
  )
) %>%
  dplyr::mutate(ACC = sample(c(0, 1), dplyr::n(), replace = TRUE)) %>%
  dplyr::group_by(id, Type) %>%
  dplyr::group_modify(
    ~ .x %>%
      dplyr::mutate(
        SSD = .prepare_ssd(
          ACC, .y$Type
        )
      )
  ) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(
    RT = ifelse(ACC == 1 & Type != "Go", 0, rexp(dplyr::n(), 0.001))
  ) %>%
  dplyr::arrange(id, Trial)

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, stopsignal))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, stopsignal, by = c("id", "id1")))
})
