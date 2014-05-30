context("fake")

test_that("default prey", {
  predatorPrey <- GetPreyOf()
  expect_that(length(predatorPrey) > 0, is_true())
  expect_that(length(predatorPrey$source_taxon_name)>10, is_true())
})

test_that("prey of Ariopsis felis", {
  prey <- GetPreyOf("Ariopsis felis")
  expect_true(length(prey) > 0)
})

test_that("predator of rats", {
  predators <- GetPredatorsOf("Rattus rattus")
  expect_true(length(predators) > 0)
})

test_that("cypher query", {
  human <- Query("START taxon = node:taxons(name='Homo sapiens') RETURN taxon.name as `name`, taxon.path as `path`");
  expect_equal(human.name, "Homo sapiens")
  expect_equal(human.path, "donald duck")
})
