test_that("Test `bps()`: Behavioral Pattern Separation", {
  expect_snapshot(
    bps(
      jsonlite::read_json(
        "data/bps/sample_bps.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `bps()`: corrupted data", {
  expect_snapshot(bps(data.frame()))
  expect_snapshot(bps(1))
})
