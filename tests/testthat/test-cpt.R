test_that("`cpt()` should work on sample data", {
  sample_data <- jsonlite::stream_in(file("data/cpt/sample_cpt.json"))
  expect_snapshot(cpt(sample_data))
})
