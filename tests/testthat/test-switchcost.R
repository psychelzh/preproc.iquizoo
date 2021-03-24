test_that("Test `switchcost()`: Card Sorting Test", {
  expect_snapshot(
    switchcost(
      jsonlite::read_json(
        "data/switchcost/sample_cardsort.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `switchcost()`: Card Sorting Test (old version)", {
  expect_snapshot(
    switchcost(
      jsonlite::read_json(
        "data/switchcost/sample_cardsort_old.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `switchcost()`: Card Sorting Test (5 blocks)", {
  expect_snapshot(
    switchcost(
      jsonlite::read_json(
        "data/switchcost/sample_cardsort5.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `switchcost()`: Card Sorting Test (6 blocks)", {
  expect_snapshot(
    switchcost(
      jsonlite::read_json(
        "data/switchcost/sample_cardsort6.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `switchcost()`: Card Sorting Test (with invalid responses)", {
  expect_snapshot(
    switchcost(
      jsonlite::read_json(
        "data/switchcost/sample_cardsort_issue.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `switchcost()`: corrupted data", {
  expect_snapshot(switchcost(data.frame()))
  expect_snapshot(switchcost(1))
})
