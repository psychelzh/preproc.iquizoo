test_that("Test `nback()`: One Back Test", {
  expect_snapshot(
    nback(
      jsonlite::read_json(
        "data/nback/sample_nback1.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `nback()`: Two Back Test", {
  expect_snapshot(
    nback(
      jsonlite::read_json(
        "data/nback/sample_nback2.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `nback()`: Three Back Test", {
  expect_snapshot(
    nback(
      jsonlite::read_json(
        "data/nback/sample_nback3.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `nback()`: Four Back Test", {
  expect_snapshot(
    nback(
      jsonlite::read_json(
        "data/nback/sample_nback4.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `nback()` on corrupted data", {
  expect_snapshot(nback(data.frame()))
  expect_snapshot(nback(1))
})
