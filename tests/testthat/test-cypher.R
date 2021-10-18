context("rglobi")


skip_if_neo4j_unavailable <- function(name, some_test) {
  skip_if(!has_neo4j_api(),'neo4j not available: are you online?')
}

test_that("cypher query", {
  skip_if_neo4j_unavailable()
  human <- query("START taxon = node:taxons(name='Homo sapiens') RETURN taxon.name as `name`, taxon.path as `path` LIMIT 1")
  expect_equal(as.character(human$name), "Homo sapiens")
  expect_equal(class(human$name), "character")
  taxon_path <- as.character(human$path)
  expect_equal(grep('Primates', taxon_path), 1)
})

test_that("no result cypher query", {
  skip_if_neo4j_unavailable()
  res <- query("START predatorTaxon = node:taxons(name='Calisto hysius') MATCH preyTaxon<-[:CLASSIFIED_AS]-prey<-[:ATE|PREYED_ON]-predator-[:CLASSIFIED_AS]->predatorTaxon WHERE has(preyTaxon.path) RETURN distinct(preyTaxon.name), preyTaxon.path as `prey.taxon.path`")
  expect_equal(0, length(res))
})

test_that("invalid cypher query", {
  skip_if_neo4j_unavailable()
  tryCatch (
    query("this is not a valid cypher query"),
    error = function(e) {
      expect_equal(e$message, 'Invalid input \'t\': expected <init> (line 1, column 1 (offset: 0))\n\"this is not a valid cypher query\"\n ^') 
    }

  )
})
