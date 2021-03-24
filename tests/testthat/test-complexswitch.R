test_that("Test `complexswitch()`: Birds Migration", {
  expect_snapshot(
    complexswitch(
      jsonlite::read_json(
        "data/complexswitch/sample_birds.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `complexswitch()`: Faces", {
  expect_snapshot(
    complexswitch(
      jsonlite::read_json(
        "data/complexswitch/sample_faces.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `complexswitch()`: Faces (invalid response data)", {
  expect_snapshot(
    complexswitch(
      jsonlite::read_json(
        "data/complexswitch/sample_faces_issue.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `complexswitch()`: corrupted data", {
  expect_snapshot(complexswitch(data.frame()))
  expect_snapshot(complexswitch(1))
})
