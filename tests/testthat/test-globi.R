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

test_that("no result cypher query", {
  res <- query("START predatorTaxon = node:taxons(name='Calisto hysius') MATCH preyTaxon<-[:CLASSIFIED_AS]-prey<-[:ATE|PREYED_ON]-predator-[:CLASSIFIED_AS]->predatorTaxon WHERE has(preyTaxon.path) RETURN distinct(preyTaxon.name), preyTaxon.path as `prey.taxon.path`")
  expect_equal(0, length(res))
})

test_that("invalid cypher query", {
  throws_error(query("this is not a valid cypher query"))
})

test_that("interactions returned based on species", {
  rattus <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus")
  expect_equal(as.character(rattus$source_taxon_name[1]), "Rattus rattus")
  expect_equal(as.character(rattus$source_taxon_path[1]), "Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus")
})

test_that("interactions subsetted by adding additional information", {
  rattus <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus")
  rattusaves <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", targettaxon="Aves")
  expect_less_than(dim(rattusaves)[1], dim(rattus)[1])
  expect_equal(dim(merge(rattusaves,rattus, all.x=T, all.y=T)), dim(rattus))
})

test_that("bad bouding box throws error", {
  throws_error(get_interactions_by_taxa(sourcetaxon = "Rattus rattus", bbox=c(23,35,22,50)))
  throws_error(get_interactions_by_taxa(sourcetaxon = "Rattus rattus", bbox=c(23,35,22)))
  throws_error(get_interaction_areas(bbox=c(23,35,22,50)))
  throws_error(get_interactions_in_area(bbox=c(23,35,22,50)))
})

test_that("interaction types", {
  types <- get_interaction_types()
  expect_true('preysOn' %in% types$interaction)
  expect_true('preyedUponBy' %in% types$interaction)
})

test_that("interaction in area", {
  interactions <- get_interactions_in_area(bbox=c(-97.0, 17.5, -81, 31))
  expect_true(length(interactions$source_taxon_name) > 10)
})

test_that("interaction matrix can be built", {
  interaction.matrix <- get_interaction_matrix(source.taxon.names = list('Homo sapiens'), target.taxon.names = list('Mammalia', 'Aves'));
  expect_true('Mammalia' %in% names(interaction.matrix))
  expect_true('Homo sapiens' %in% interaction.matrix[,1][[1]])
})
