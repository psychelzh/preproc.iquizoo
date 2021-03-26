test_that("Test `london()`: London Tower Test", {
  expect_snapshot(
    london(
      jsonlite::read_json(
        "data/london/sample_london.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `london()`: London Tower Test (with no response trials)", {
  expect_snapshot(
    london(
      jsonlite::read_json(
        "data/london/sample_london_no_resp.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `london()`: corrupted data", {
  expect_snapshot(london(data.frame()))
  expect_snapshot(london(1))
})
