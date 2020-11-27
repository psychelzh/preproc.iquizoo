test_that("`switchcost` should work for data with blocks of no responses", {
  test_sample(
    switchcost,
    "data/switchcost/sample_cardsort_issue.json",
    "data/switchcost/result_cardsort_issue.json",
    warn_msg = "At least one block has no response."
  )
})
