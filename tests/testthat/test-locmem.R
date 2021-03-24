test_that("Test `locmem()`: Location Memory", {
  expect_snapshot(
    locmem(
      jsonlite::read_json(
        "data/locmem/sample_locmem.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `locmem()`: Location Memory (junior version)", {
  expect_snapshot(
    locmem(
      jsonlite::read_json(
        "data/locmem/sample_locmemjr.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `locmem()`: Location Memory (medium version)", {
  expect_snapshot(
    locmem(
      jsonlite::read_json(
        "data/locmem/sample_locmemmed.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `locmem()`: corrupted data", {
  expect_snapshot(locmem(data.frame()))
  expect_snapshot(locmem(1))
})
