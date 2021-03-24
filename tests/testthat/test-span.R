test_that("Test `span()`: Backward Digit Span", {
  expect_snapshot(
    span(
      jsonlite::read_json(
        "data/span/sample_bds.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `span()`: Forward Digit Span", {
  expect_snapshot(
    span(
      jsonlite::read_json(
        "data/span/sample_fds.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `span()`: Forward Word Span", {
  expect_snapshot(
    span(
      jsonlite::read_json(
        "data/span/sample_fws.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `span()`: Multiple Object Tracking", {
  expect_snapshot(
    span(
      jsonlite::read_json(
        "data/span/sample_mot.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `span()`: Multiple Object Tracking (with distractors)", {
  expect_snapshot(
    span(
      jsonlite::read_json(
        "data/span/sample_mot2.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `span()`: Symmetry Complex Span", {
  expect_snapshot(
    span(
      jsonlite::read_json(
        "data/span/sample_sspan.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `span()`: Spatial Short-Term Memory", {
  expect_snapshot(
    span(
      jsonlite::read_json(
        "data/span/sample_sstm.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `span()`: Spatial Short-term Memory (simple version)", {
  expect_snapshot(
    span(
      jsonlite::read_json(
        "data/span/sample_sstms.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `span()`: corrupted data", {
  expect_snapshot(span(data.frame()))
  expect_snapshot(span(1))
})
