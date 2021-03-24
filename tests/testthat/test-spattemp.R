test_that("Test `spattemp()`: Camera (hide version)", {
  expect_snapshot(
    spattemp(
      jsonlite::read_json(
        "data/spattemp/sample_camera.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `spattemp()`: Camera (stay version)", {
  expect_snapshot(
    spattemp(
      jsonlite::read_json(
        "data/spattemp/sample_camera2.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `spattemp()`: Camera (junior version)", {
  expect_snapshot(
    spattemp(
      jsonlite::read_json(
        "data/spattemp/sample_camerajr.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `spattemp()`: Camera (medium version)", {
  expect_snapshot(
    spattemp(
      jsonlite::read_json(
        "data/spattemp/sample_cameramed.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `spattemp()`: corrupted data", {
  expect_snapshot(spattemp(data.frame()))
  expect_snapshot(spattemp(1))
})
