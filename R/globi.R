#' Returns 3.
three <- function() {
  3
}

#' Check to see if our argument is three.
is_three <- function(x) {
  see_if(are_equal(3, x))
}

GetPreyOf <- function() {
  # Gets known prey of taxon with name
  # 
  # Args:
  #   Taxon name of predator.
  # Returns:
  #   List of prey names.
  return GetInteractions()
}

GetInteractions <- function(type = 'preysOn') {
  return read.csv(text = httr:content(httr::GET('http://api.globalbioticinteractions.org/taxon/Homo%20sapiens/preysOn?type=csv')))
}
