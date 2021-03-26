test_that("Test `srt()`: Simple Reaction Time", {
  expect_snapshot(
    srt(
      jsonlite::read_json(
        "data/srt/sample_srt.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `srt()`: Simple Reaction Time (abnormal response)", {
  expect_snapshot(
    srt(
      jsonlite::read_json(
        "data/srt/sample_srt_abnormal.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `srt()`: corrupted data", {
  expect_snapshot(srt(data.frame()))
  expect_snapshot(srt(1))
})
