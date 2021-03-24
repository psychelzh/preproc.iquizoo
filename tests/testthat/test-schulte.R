test_that("Test `schulte()`: Schulte Grid Test (junior version)", {
  expect_snapshot(
    schulte(
      jsonlite::read_json(
        "data/schulte/sample_schultejr.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `schulte()`: Schulte Grid Test (medium version)", {
  expect_snapshot(
    schulte(
      jsonlite::read_json(
        "data/schulte/sample_schultemed.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `schulte()`: Schulte Grid Test (advanced version)", {
  expect_snapshot(
    schulte(
      jsonlite::read_json(
        "data/schulte/sample_schulteadv.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `schulte()`: corrupted data", {
  expect_snapshot(schulte(data.frame()))
  expect_snapshot(schulte(1))
})
