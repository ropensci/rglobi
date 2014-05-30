GetGloBIURL <- function(suffix) {
  paste("http://api.globalbioticinteractions.org", suffix, sep = "")
}

GetInteractions <- function(taxon = "Homo sapiens", interactionType = "preysOn") {
  query <- paste("/taxon/", RCurl::curlEscape(taxon), "/", interactionType, "?type=csv", sep="") 
  requestURL = GetGloBIURL(query)
  read.csv(text = httr::content(httr::GET(requestURL)))
}

GetPreyOf <- function(taxon = "Homo sapiens") {
  # Gets known prey of taxon with name
  # 
  # Args:
  #   Taxon name of predator.
  # Returns:
  #   List of prey names.
  GetInteractions(taxon)
}

GetPredatorsOf <- function(taxon = "Rattus rattus") {
  GetInteractions(taxon, "preyedUponBy")
}

Query <- function(querystring) {
  # Executes Cypher Query against GloBI's Neo4j instance. See https://github.com/jhpoelen/eol-globi-data/wiki/cypher for examples.
  #
  # Args:
  #   Cypher query
  # Returns:
  #	  Cypher query results

  h <- RCurl::basicTextGatherer()

  RCurl::curlPerform(
    url=GetGloBIURL(":7474/db/data/ext/CypherPlugin/graphdb/execute_query"),
    postfields=paste('query',RCurl::curlEscape(querystring), sep='='),
		writefunction = h$update,
		verbose = FALSE
  )
  result <- rjson::fromJSON(h$value())
  data <- data.frame(t(sapply(result$data, unlist)))
  names(data) <- result$columns
  data
}
