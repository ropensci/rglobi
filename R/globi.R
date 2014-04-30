#' Returns 3.
three <- function() {
  3
}

#' Check to see if our argument is three.
is_three <- function(x) {
  see_if(are_equal(3, x))
}

GetPreyOf <- function(taxon.name = 'Homo sapiens') {
  # Gets known prey of taxon with name
  # 
  # Args:
  #   Taxon name of predator.
  # Returns:
  #   List of prey names.
  return (GET('http://api.globalbioticinteractions.org/taxon/Homo%20sapiens/presOn?type=csv'))
}
