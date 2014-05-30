GetGloBIURL <- function(suffix) {
  paste("http://api.globalbioticinteractions.org", suffix, sep = "")
}

GetInteractions <- function(type = "preysOn") {
  requestURL = GetGloBIURL("/taxon/Homo%20sapiens/preysOn?type=csv")
  read.csv(text = httr::content(httr::GET(requestURL)))
}

GetPreyOf <- function() {
  # Gets known prey of taxon with name
  # 
  # Args:
  #   Taxon name of predator.
  # Returns:
  #   List of prey names.
  GetInteractions()
}

Query <- function(querystring) {
  # Executes Cypher Query against GloBI's Neo4j instance
  #
  # Args:
  #   Cypher query
  # Returns:
  #	  Cypher query results

  h <- basicTextGatherer()

  curlPerform(
    url=GetGloBIURL(":7474/db/data/ext/CypherPlugin/graphdb/execute_query"),
    postfields=paste('query',curlEscape(querystring), sep='='),
		writefunction = h$update,
		verbose = FALSE
  )
  result <- fromJSON(h$value())
  data <- data.frame(t(sapply(result$data, unlist)))
  names(data) <- result$columns
  data
}
