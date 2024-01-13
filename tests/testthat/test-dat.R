test_that("Basic test", {
  data <- data.frame(id = 1:2, words = c("A-B-C-D-E-F-G", "A-I"))
  dists <- withr::with_seed(
    1,
    {
      nobs <- 7
      mat <- matrix(rnorm(100 * nobs), nrow = nobs)
      rownames(mat) <- LETTERS[1:nobs]
    }
  )
  dat(data, .by = "id", .extra = list(w2v = mat)) |>
    expect_snapshot_value(style = "json2")
})
