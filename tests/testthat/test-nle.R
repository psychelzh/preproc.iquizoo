test_that("Test `nle()`: Number Line Estimation (junior version)", {
  expect_snapshot(
    nle(
      jsonlite::read_json(
        "data/nle/sample_nlejr.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `nle()`: Number Line Estimation (medium version)", {
  expect_snapshot(
    nle(
      jsonlite::read_json(
        "data/nle/sample_nlemed.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `nle()`: corrupted data", {
  expect_snapshot(nle(data.frame()))
  expect_snapshot(nle(1))
})
