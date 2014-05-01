context("fake")

test_that("default prey", {
  predatorPrey <- GetPreyOf()
  expect_that(length(predatorPrey) > 0, is_true())
  expect_that(length(predatorPrey$source_taxon_name)>10, is_true())
})
