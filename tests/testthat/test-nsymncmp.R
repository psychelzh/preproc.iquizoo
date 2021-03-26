test_that("Test `nsymncmp()`: Nonsymbolic Numeric Comparison", {
  expect_snapshot(
    nsymncmp(
      jsonlite::read_json(
        "data/nsymncmp/sample_nsymncmp.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `nsymncmp()`: corrupted data", {
  expect_snapshot(nsymncmp(data.frame()))
  expect_snapshot(nsymncmp(1))
})
