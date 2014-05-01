GetInteractions <- function(type = 'preysOn') {
  read.csv(text = httr::content(httr::GET('http://api.globalbioticinteractions.org/taxon/Homo%20sapiens/preysOn?type=csv')))
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
