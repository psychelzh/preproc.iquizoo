test_that("Test `drm()`: DRM paradigm", {
  expect_snapshot(
    drm(
      jsonlite::read_json(
        "data/drm/sample_drm.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `drm()`: corrupted data", {
  expect_snapshot(drm(data.frame()))
  expect_snapshot(drm(1))
})
