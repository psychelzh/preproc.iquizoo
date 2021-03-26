test_that("Test `bart()`: Balloon Analogue Risk Task", {
  expect_snapshot(
    bart(
      jsonlite::read_json(
        "data/bart/sample_bart.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `bart()`: corrupted data", {
  expect_snapshot(bart(data.frame()))
  expect_snapshot(bart(1))
})
