test_that("Test `cpt()`: Continuous Performance Test", {
  expect_snapshot(
    cpt(
      jsonlite::read_json(
        "data/cpt/sample_cpt.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `cpt()`: corrupted data", {
  expect_snapshot(cpt(data.frame()))
  expect_snapshot(cpt(1))
})
