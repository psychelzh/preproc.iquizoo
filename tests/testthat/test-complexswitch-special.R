test_that("`complexswitch` should work for data with blocks of no responses", {
  test_sample(
    complexswitch,
    "data/complexswitch/sample_faces_issue.json",
    "data/complexswitch/result_faces_issue.json",
    warn_msg = "At least one block has no response."
  )
})
