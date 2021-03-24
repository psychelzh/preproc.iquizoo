test_that("Test `crt()`: Choice Reaction Time", {
  expect_snapshot(
    crt(
      jsonlite::read_json(
        "data/crt/sample_crt.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `crt()`: corrupted data", {
  expect_snapshot(crt(data.frame()))
  expect_snapshot(crt(1))
})
