test_that("Test `congeff()`: Flanker Paradigm", {
  expect_snapshot(
    congeff(
      jsonlite::read_json(
        "data/congeff/sample_flanker.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `congeff()`: Flanker Paradigm (temp version)", {
  expect_snapshot(
    congeff(
      jsonlite::read_json(
        "data/congeff/sample_flanker2.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `congeff()`: Stroop Paradigm", {
  expect_snapshot(
    congeff(
      jsonlite::read_json(
        "data/congeff/sample_stroop.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `congeff()` on corrupted data", {
  expect_snapshot(congeff(data.frame()))
  expect_snapshot(congeff(1))
})
