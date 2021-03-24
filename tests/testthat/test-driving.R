test_that("Test `driving()`: Driving Test (with 0 still durations)", {
  expect_snapshot(
    driving(
      jsonlite::read_json(
        "data/driving/sample_driving.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `driving()`: Driving Test", {
  expect_snapshot(
    driving(
      jsonlite::read_json(
        "data/driving/sample_driving2.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `driving()`: corrupted data", {
  expect_snapshot(driving(data.frame()))
  expect_snapshot(driving(1))
})
