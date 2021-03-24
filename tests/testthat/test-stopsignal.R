test_that("Test `stopsignal()`: Stop Signal Task", {
  expect_snapshot(
    stopsignal(
      jsonlite::read_json(
        "data/stopsignal/sample_stopsignal.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `stopsignal()`: corrupted data", {
  expect_snapshot(stopsignal(data.frame()))
  expect_snapshot(stopsignal(1))
})
