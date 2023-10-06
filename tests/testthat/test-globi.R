context("rglobi")


test_that("default prey", {
  predatorPrey <- get_prey_of(taxon = "Homo sapiens", read_csv = read_csv_offline)
  expect_true(length(predatorPrey) > 0)
  expect_true(length(predatorPrey$source_taxon_name) > 10)
})

test_that("prey of Ariopsis felis", {
  prey <- get_prey_of(taxon = "Ariopsis felis", read_csv = read_csv_offline)
  expect_true(length(prey) > 0)
})

test_that("predator of rats", {
  predators <- get_predators_of(taxon = "Rattus rattus", read_csv = read_csv_offline)
  expect_true(length(predators) > 0)
})

test_that("interactions returned based on species", {
  rattus <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", read_csv = read_csv_offline)
  expect_match(as.character(rattus$source_taxon_name[1]), "^Rattus rattus")
  taxon_path <- as.character(rattus$source_taxon_path[1])
  expect_equal(grep('Muridae', taxon_path), 1)
})

test_that("interactions subsetted by adding additional information", {
  interaction_types <- c('eats', 'eatenBy')
  rattus <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", interactiontype = interaction_types, read_csv = read_csv_offline)
  rattusaves <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", targettaxon="Aves", interactiontype= interaction_types, read_csv = read_csv_offline)
  expect_equal(class(rattus$source_taxon_name), "character")
  expect_true(dim(rattus)[1] > 0)
  expect_lt(dim(rattusaves)[1], dim(rattus)[1])
  expect_equal(dim(unique(rbind(rattusaves,rattus))), dim(unique(rattus)))
})

test_that("interactions subsetted by adding additional information all interaction types", {
  rattus <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", read_csv = read_csv_offline)
  rattusaves <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", targettaxon="Aves", read_csv = read_csv_offline)
  expect_true(dim(rattus)[1] > 0)
  expect_lt(dim(rattusaves)[1], dim(rattus)[1])
  # note that some interaction types (e.g. interactsWith) are symmetric
  # if a specific source (e.g. Thessen et al. 2014) reported a -[:INTERACTS_WITH]-> b and (a separate entry) b -[:INTERACTS_WITH]-> a, then both show up when looking for interactions between a and b, because the inverse of interactsWith is interactsWith.
  expect_equal(dim(unique(rbind(rattusaves,rattus))), dim(unique(rattus)))
})


expect_limit_warning <- function(x) {
  expect_warning(x, "Default results limit reached. Consider increasing limit parameter and/or using pagination to retrieve all results. See rglobi vignette section on pagination for help modifying limit/skip parameters.");
}

test_that("interactions subsetted by adding additional information all interaction types include observations", {
  expect_limit_warning(rattus <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", returnobservations = TRUE, , read_csv = read_csv_offline))
  expect_limit_warning(rattusaves <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", targettaxon="Aves", returnobservations = TRUE, , read_csv = read_csv_offline))
  expect_true(dim(rattus)[1] > 0)
  expect_lte(dim(rattusaves)[1], dim(rattus)[1])
})

test_that("interactions subsetted by adding additional information using otherkeys, all interaction types include observations", {
  rattus <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", read_csv = read_csv_offline)
  rattusaves <- get_interactions_by_taxa(sourcetaxon = "Rattus rattus", otherkeys = list("targetTaxon" = "Aves"), read_csv = read_csv_offline)
  expect_true(dim(rattus)[1] > 0)
  expect_lt(dim(rattusaves)[1], dim(rattus)[1])
  # note that some interaction types (e.g. interactsWith) are symmetric
  # if a specific source (e.g. Thessen et al. 2014) reported a -[:INTERACTS_WITH]-> b and (a separate entry) b -[:INTERACTS_WITH]-> a, then both show up when looking for interactions between a and b, because the inverse of interactsWith is interactsWith.
  expect_equal(dim(merge(unique(rattusaves),unique(rattus), all.x=TRUE, all.y=TRUE)), dim(unique(rattus)))
})

test_that("bad bounding box throws error", {
  expect_error(get_interactions_by_taxa(sourcetaxon = "Rattus rattus", bbox=c(23,35,22,50), read_csv = read_csv_offline ), "Coordinates entered incorrectly")
})

test_that("interaction types", {
  types <- get_interaction_types(read_csv = read_csv_offline)
  expect_true('preysOn' %in% types$interaction)
  expect_true('preyedUponBy' %in% types$interaction)
})

test_that("data fields can be retrieved", {
  fields <- get_data_fields(read_csv = read_csv_offline)
  expect_true('source_taxon_name' %in% fields$name)
})


test_that("interaction in area", {
  expect_limit_warning(interactions <- get_interactions_in_area(bbox=c(-97.0, 17.5, -81, 31), read_csv = read_csv_offline))
  expect_equal(class(interactions$source_taxon_name), "character")
  expect_true(length(interactions$source_taxon_name) > 10)
})

test_that("interaction matrix can be retrieved", {
  interaction.matrix <- get_interaction_matrix(source.taxon.names = list('Homo sapiens'), target.taxon.names = list('Mammalia', 'Aves'), read_csv = read_csv_offline);
  expect_true('Mammalia' %in% names(interaction.matrix))
  expect_true('Homo sapiens' %in% interaction.matrix[,1][[1]])
  expect_equal(unlist(interaction.matrix[[2]]), 1)
})

test_that("interaction matrix with interaction type can be retrieved", {
  interaction.matrix <- get_interaction_matrix(list('Cymothoa excisa'), list('Micropogonias undulatus'), 'parasiteOf', read_csv = read_csv_offline)
  expect_equal(unlist(interaction.matrix[[2]]), 1)
})

test_that("interactions can be retrieved by type", {
  interactions <- rglobi::get_interactions_by_type(interactiontype = c('eats', 'eatenBy'), showfield = c('source_taxon_name', 'interaction_type', 'target_taxon_name'), otherkeys = list(limit=5), read_csv = read_csv_offline)
  expect_equal(length(interactions$source_taxon_name), 5)
})
