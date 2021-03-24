test_that("Test `wxpred()`: Weather Prediction Paradigm", {
  expect_snapshot(
    wxpred(
      jsonlite::read_json(
        "data/wxpred/sample_wxpred.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `wxpred()`: Weather Prediction Paradigm (New version)", {
  expect_snapshot(
    wxpred(
      jsonlite::read_json(
        "data/wxpred/sample_wxpred_new.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `wxpred()`: corrupted data", {
  expect_snapshot(wxpred(data.frame()))
  expect_snapshot(wxpred(1))
})
