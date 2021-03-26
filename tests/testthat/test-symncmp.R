test_that("Test `symncmp()`: Symbolic Numeric Comparison", {
  expect_snapshot(
    symncmp(
      jsonlite::read_json(
        "data/symncmp/sample_symncmp.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `symncmp()`: corrupted data", {
  expect_snapshot(symncmp(data.frame()))
  expect_snapshot(symncmp(1))
})
