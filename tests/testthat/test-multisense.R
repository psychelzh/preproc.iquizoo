test_that("Test `multisense()`: Multisense Test", {
  expect_snapshot(
    multisense(
      jsonlite::read_json(
        "data/multisense/sample_multisense.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `multisense()`: Multisense Test (no sound responses)", {
  expect_snapshot(
    multisense(
      jsonlite::read_json(
        "data/multisense/sample_multisense_no_sound.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `multisense()`: corrupted data", {
  expect_snapshot(multisense(data.frame()))
  expect_snapshot(multisense(1))
})
