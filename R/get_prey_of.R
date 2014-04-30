GetPreyOf <- function(taxon.name = 'Homo sapiens') {
  # Gets known prey of taxon with name
  # 
  # Args:
  #   Taxon name of predator.
  # Returns:
  #   List of prey names.
  return (GET('http://api.globalbioticinteractions.org/taxon/Homo%20sapiens/presOn?type=csv'))
}
