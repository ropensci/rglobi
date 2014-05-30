context("fake")

test_that("default prey", {
  predatorPrey <- GetPreyOf()
  expect_that(length(predatorPrey) > 0, is_true())
  expect_that(length(predatorPrey$source_taxon_name)>10, is_true())
})

that_that("cypher query", {
  human <- Query("START taxon = node:taxons(name='Homo sapiens') RETURN taxon.name as `name`, taxon.path as `path`");
  expect_that(human.name, is_equal('Homo sapiens'))
  expect_that(human.path, is_equal('donald duck'))
})
