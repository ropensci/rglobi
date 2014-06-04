context("fake")

test_that("default prey", {
  predatorPrey <- get_prey_of()
  expect_that(length(predatorPrey) > 0, is_true())
  expect_that(length(predatorPrey$source_taxon_name)>10, is_true())
})

test_that("prey of Ariopsis felis", {
  prey <- get_prey_of("Ariopsis felis")
  expect_true(length(prey) > 0)
})

test_that("predator of rats", {
  predators <- get_predators_of("Rattus rattus")
  expect_true(length(predators) > 0)
})

test_that("cypher query", {
  human <- query("START taxon = node:taxons(name='Homo sapiens') RETURN taxon.name as `name`, taxon.path as `path`")
  expect_equal(as.character(human$name), "Homo sapiens")
  expect_equal(as.character(human$path), "Animalia | Chordata | Mammalia | Primates | Hominidae | Homo | Homo sapiens")
})
