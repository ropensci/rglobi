# Get GloBI Options

# @param opts list containing options
# @return list with options including default for missing options

add_missing_options <- function(opts) {
  defaults <- list(host = 'api.globalbioticinteractions.org', port = 80)
  opts <- c(opts, defaults)
  opts[unique(names(opts))]
}

# Get GloBI URL 
#
# @param suffix additional information passed to api
# @param opts list of options to configure GloBI API
# @return url address used to call api 
get_globi_url <- function(suffix, opts = list()) {
  opts <- add_missing_options(opts)
  paste("http://", opts$host, ":", opts$port, suffix, sep = "")
}

#' Get Species Interaction from GloBI 
#'
#' @param taxon canonical scientic name of source taxon (e.g. Homo sapiens) 
#' @param interaction.type the preferred interaction type (e.g. preysOn)
#' @param opts list of options to configure GloBI API
#' @return species interactions between source and target taxa 
#' @family interactions
#' @export
#' @examples
#' get_interactions("Homo sapiens", "preysOn")
#' get_interactions("Insecta", "parasiteOf")
get_interactions <- function(taxon = "Homo sapiens", interaction.type = "preysOn", opts = list()) {
  query <- paste("/taxon/", RCurl::curlEscape(taxon), "/", interaction.type, "?type=csv", sep="") 
  requestURL = get_globi_url(query, opts = opts)
  read.csv(text = httr::content(httr::GET(requestURL)))
}

#' Get a List of Prey for given Predator Taxon 
#'
#' @param taxon scientific name of predator taxon. Can be any taxonomic rank (e.g. Homo sapiens, Animalia)
#' @param opts list of named options to configure GloBI API
#' @return list of recorded predator-prey interactions that involve the desired predator taxon
#' @export
#' @family interactions
#' @examples
#' get_prey_of("Homo sapiens")
#' get_prey_of("Primates")
get_prey_of <- function(taxon = "Homo sapiens", opts = list()) {
  get_interactions(taxon, opts = opts)
}

#' Get a List of Predators of a Given Prey Taxon
#'
#' @param taxon scientific name of prey taxon. Can be any taxonomic rank (e.g. Rattus rattus, Decapoda)
#' @param opts list of named options to configure the GloBI API
#' @return list of recorded prey-predator interactions that involve the desired prey taxon.
#' @export
#' @family interactions
#' @examples
#' get_predators_of("Rattus rattus")
#' get_predators_of("Primates")
get_predators_of <- function(taxon = "Rattus rattus", opts = list()) {
  get_interactions(taxon, "preyedUponBy", opts = opts)
}

#' Executes a Cypher Query Against GloBI's Neo4j Instance
#' 
#' @param cypherQuery Cypher query (see http://github.com/jhpoelen/eol-globi-data/wiki/cypher for examples)
#' @param opts list of named options to configure GloBI API
#' @return result of cypher query string 
#' @export
query <- function(cypherQuery, opts = list(port = 7474)) {
  h <- RCurl::basicTextGatherer()

  RCurl::curlPerform(
    url=get_globi_url("/db/data/ext/CypherPlugin/graphdb/execute_query", opts),
    postfields=paste('query',RCurl::curlEscape(cypherQuery), sep='='),
		writefunction = h$update,
		verbose = FALSE
  )
  result <- rjson::fromJSON(h$value())
  data <- data.frame(t(sapply(result$data, unlist)))
  names(data) <- result$columns
  data
}

create_bbox_param <- function(bbox) {
  if (is.null(bbox)){
    ""
  } else {
    if (is.numeric(bbox) & length(bbox)==4){
			if (max (abs (bbox)) < 181 & bbox[1] <= bbox[3] & bbox[2] <= bbox[4]){
				paste ("bbox=",bbox[1],",", 
					bbox[2],",", bbox[3],",", bbox[4], "&", sep="")
			} else {
				stop ("Coordinates entered incorrectly")
			}} else {
        stop ("Coordinates entered incorrectly")
			}
  }
}

#' @title Return interactions involving specific taxa
#'
#' @description Returns interactions involving specific taxa.  Secondary (target) 
#' taxa and spatial boundaries may also be set
#'
#' @param sourcetaxon Taxa of interest (consumer, predator, parasite); may be 
#' specified as "Genus species" or higher level (e.g., Genus, Family, Class).
#' @param targettaxon Taxa of interest (prey, host); may be specified as "Genus 
#' species" or higher level (e.g., Genus, Family, Class)
#' @param bbox Coordinates in EPSG:4326 decimal degrees defining "left, bottom,
#'  right, top" of bounding box
#' @param returnobservations if true, all individual observations are returned, 
#' else only distinct relationships
#' @return Returns data frame of interactions
#' @keywords database
#' @export
#' @note For data sources in which type of interactions were not specified, the interaction is labeled "interacts_with"
#' @family interactions
#' @examples
#' get_interactions_by_taxa(sourcetaxon = "Rattus")
#' get_interactions_by_taxa(sourcetaxon = "Aves", targettaxon = "Rattus")
#' get_interactions_by_taxa(sourcetaxon = "Rattus rattus", 
#' bbox = c(-67.87,12.79,-57.08,23.32))
get_interactions_by_taxa <- function(sourcetaxon, targettaxon = NULL, 
  bbox = NULL, returnobservations = F){
  sourcetaxon <- gsub(" ", "%20", sourcetaxon)
  requesturl <- get_globi_url("/interaction?")	
  for (i in 1:length (sourcetaxon)){
    requesturl <- paste (requesturl, "sourceTaxon=",sourcetaxon[i], "&", sep="")
  }

  if (!is.null (targettaxon)){
    targettaxon <- gsub(" ", "%20", targettaxon)
    for (i in 1:length (targettaxon)){
      requesturl <- paste (requesturl, "targetTaxon=", targettaxon[i], "&", sep="")
    }	
  }

  requesturl <- paste(requesturl, create_bbox_param(bbox), sep="")

	if (returnobservations %in% c (T, F)){
		requesturl<-paste(requesturl, "includeObservations=", tolower(as.character(returnobservations)), "&", sep="")
	}else {
    stop ("Incorrect entry for returnobservations")
  }
		
  requesturltype <- paste (requesturl, "type=csv", sep="")
  read.csv(requesturltype)	
}	

#' @title Return all interactions in specified area
#'
#' @description Returns all interactions in data base in area specified in 
#' arguments
#'
#' @param bbox Coordinates in EPSG:4326 decimal degrees defining "left, bottom, 
#' right, top" of bounding box
#' @return Returns data frame of interactions
#' @keywords database
#' @export
#' @family areas
#' @examples
#' get_interactions_in_area(bbox = c(-67.87, 12.79, -57.08, 23.32))
get_interactions_in_area <- function(bbox){
  if (is.null(bbox)) {
    stop("no coordinates provided")
  } else {
    get_globi_url("/interaction?type=csv&", create_bbox_param(bbox))
  }
}

#' @title Find locations at which interactions were observed
#'
#' @description Returns all locations (latitude,longitude) of interactions in data
#' base or area specified in arguments
#'
#' @param bbox Coordinates in EPSG:4326 decimal degrees defining "left, bottom, 
#' right, top" of bounding box
#' @return Returns data frame of coordinates
#' @keywords database
#' @export
#' @family areas
#' @examples
#' get_interaction_areas ()
#' get_interaction_areas (bbox=c(-67.87,12.79,-57.08,23.32))
get_interaction_areas <- function(bbox = NULL){
  requesturl <- read.csv (get_globi_url("/locations?type=csv"),
    stringsAsFactors = F)
  names (requesturl) <- c ("Latitude", "Longitude")
  requesturl$Latitude <- as.numeric (requesturl$Latitude)
  requesturl$Longitude <- as.numeric (requesturl$Longitude)  

  if (!is.null(bbox)){
    if (is.numeric (bbox) & length (bbox)==4){
	    if (max(abs(bbox))<181 & bbox[1]<=bbox[3] & bbox[2]<=bbox[4]){
		    requesturl <- requesturl[requesturl$Latitude>=bbox[2] & 
            requesturl$Latitude<=bbox[4] & requesturl$Longitude>=bbox[1] & 
            requesturl$Longitude<=bbox[3], ]
	      return(requesturl)
	    }
    } else {
        stop("Coordinates entered incorrectly")	      
      }
  } else {requesturl}
}

#' @title List interactions identified in GloBI database
#'
#' @description Returns data frame with supported interaction types
#'
#' @return Returns data frame of supported interaction types
#' @keywords database
#' @export
#' @family interactions
#' @examples
#' get_interaction_types()
get_interaction_types <- function() {
  requesttypes <- read.table(get_globi_url("/interactionTypes"),header = F, sep="}",
    stringsAsFactors = F, strip.white = T)
  requesttypes <- t(requesttypes)
  requesttypes <- gsub("[{} ]", "", requesttypes)
  requesttypes <- gsub("^,", "", requesttypes)
  requesttypes <- sub("source:" ,"", requesttypes)
  requesttypes <- sub("target:" ,"", requesttypes)
  requesttypes <- sub(":" ,",", requesttypes)
  requesttypes <- requesttypes[!is.na(requesttypes)]
  requesttypes <- matrix(unlist(strsplit(requesttypes,",")), ncol=3, byrow=T)
  requesttypes <- data.frame(requesttypes)
  names(requesttypes) <- c("Interaction", "Source", 'Target')
  return(requesttypes)
}
