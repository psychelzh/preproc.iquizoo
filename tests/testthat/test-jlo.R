test_that("Test `jlo()`: Judgment of Line Orientation", {
  expect_snapshot(
    jlo(
      jsonlite::read_json(
        "data/jlo/sample_jlo.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `jlo()`: corrupted data", {
  expect_snapshot(jlo(data.frame()))
  expect_snapshot(jlo(1))
})
