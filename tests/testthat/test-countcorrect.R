test_that("Test `countcorrect()`: Associative Lang game (new version)", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_assoclang_new.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Associative Lang game (old version)", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_assoclang_old.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Attention Search", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_attsearch.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Calculation", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_calc.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Calculation (junior version)", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_calcjr.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Calculation (medium version)", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_calcmed.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Five Point Test", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_fpt.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Lexic Judgment", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_lexic.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Number Sets", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_numsets.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Orthography Judgment", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_ortho.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Pinyin Judgment", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_pinyin.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Semantic Judgment", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_seman.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Symbol Judgment", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_symbol.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: Tone Judgment", {
  expect_snapshot(
    countcorrect(
      jsonlite::read_json(
        "data/countcorrect/sample_tone.json",
        simplifyVector = TRUE
      )
    )
  )
})

test_that("Test `countcorrect()`: corrupted data", {
  expect_snapshot(countcorrect(data.frame()))
  expect_snapshot(countcorrect(1))
})
