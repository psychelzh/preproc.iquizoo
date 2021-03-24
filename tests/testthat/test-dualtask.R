test_that("Test `dualtask()`: Dual Task Paradigm", {
  expect_snapshot(
    dualtask(
      jsonlite::read_json(
        "data/dualtask/sample_dualtask.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `dualtask()`: corrupted data", {
  expect_snapshot(dualtask(data.frame()))
  expect_snapshot(dualtask(1))
})
