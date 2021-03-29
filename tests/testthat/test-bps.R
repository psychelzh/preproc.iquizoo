# prepare data
set.seed(1)
data <- tibble::tibble(
  id = rep(1:1000, each = 100),
  Phase = rep(c(rep("prac", 40), rep("test", 60)), times = 1000),
  Type = rep(
    c(rep(NA_character_, 40), sample(rep(c("lure", "foil", "target"), 20))),
    times = 1000
  ),
  Resp = rep(
    c(rep(c('Left', 'Right'), 20), sample(rep(c('Old', 'Similar', 'New'), 20))),
    times = 1000
  ),
  ACC = dplyr::case_when(
    Phase == "prac" ~ NA_integer_,
    Phase == "test" &
      (Type == "target" & Resp == "Old") |
      (Type == "foil" & Resp == "New") |
      (Type == "lure" & Resp == "Similar") ~ 1L,
    TRUE ~ 0L
  ),
  RT = rexp(1000 * 100, 0.001)
)

test_that("`bps()` default", {
  expect_snapshot(preproc_data(data, bps))
})

test_that("`bps()` supports no group", {
  expect_snapshot(preproc_data(data, bps, by = NULL))
})
