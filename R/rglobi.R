#' Get Globi URL 
#'
#' @param suffix additional information passed to api
#' @return url address used to call api 
get_globi_url <- function(suffix) {
  paste("http://api.globalbioticinteractions.org", suffix, sep = "")
}

#' Get Species Interaction from GloBI 
#'
#' @param taxon canonical scientic name of source taxon (e.g. Homo sapiens) 
#' @param interactionType the preferred interaction type (e.g. preysOn)
#' @return species interactions between source and target taxa 
#' @export
#' @examples
#' get_interactions("Homo sapiens", "preysOn")
#' get_interactions("Insecta", "parasiteOf")
get_interactions <- function(taxon = "Homo sapiens", interactionType = "preysOn") {
  query <- paste("/taxon/", RCurl::curlEscape(taxon), "/", interactionType, "?type=csv", sep="") 
  requestURL = get_globi_url(query)
  read.csv(text = httr::content(httr::GET(requestURL)))
}

#' Get a List of Prey for given Predator Taxon 
#'
#' @param taxon scientific name of predator taxon. Can be any taxonomic rank (e.g. Homo sapiens, Animalia)
#' @return list of recorded predator-prey interactions that involve the desired predator taxon
#' @examples
#' get_prey_of("Homo sapiens")
#' get_prey_of("Primates")
get_prey_of <- function(taxon = "Homo sapiens") {
  get_interactions(taxon)
}

#' Get a List of Predators of a Given Prey Taxon
#'
#' @param taxon scientific name of prey taxon. Can be any taxonomic rank (e.g. Rattus rattus, Decapoda)
#' @return list of recorded prey-predator interactions that involve the desired prey taxon.
#' @examples
#' get_predators_of("Rattus rattus")
#' get_predators_of("Primates")
get_predators_of <- function(taxon = "Rattus rattus") {
  get_interactions(taxon, "preyedUponBy")
}

#' Executes a Cypher Query Against GloBI's Neo4j Instance
#' 
#' @param cypherQuery Cypher query (see http://github.com/jhpoelen/eol-globi-data/wiki/cypher for examples)
#' @return result of cypher query string 
query <- function(cypherQuery) {
  h <- RCurl::basicTextGatherer()

  RCurl::curlPerform(
    url=get_globi_url(":7474/db/data/ext/CypherPlugin/graphdb/execute_query"),
    postfields=paste('query',RCurl::curlEscape(cypherQuery), sep='='),
		writefunction = h$update,
		verbose = FALSE
  )
  result <- rjson::fromJSON(h$value())
  data <- data.frame(t(sapply(result$data, unlist)))
  names(data) <- result$columns
  data
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
#' @examples
#' get_interactions_by_taxa(sourcetaxon = "Rattus")
#' get_interactions_by_taxa(sourcetaxon = "Rattus rattus", targettaxon = "Aves")
#' get_interactions_by_taxa(sourcetaxon = "Rattus rattus", 
#' bbox = c(-67.87,12.79,-57.08,23.32))
get_interactions_by_taxa <- function(sourcetaxon, targettaxon = NULL, 
  bbox = NULL, returnobservations = "false"){
  sourcetaxon <- gsub(" ", "%20", sourcetaxon)
  globiintpath <- "http://api.globalbioticinteractions.org/interaction?"	
  for (i in 1:length (sourcetaxon)){
    requesturl <- paste (globiintpath, "sourceTaxon=",sourcetaxon[i], 
      "&", sep="")
  }
	
  if (!is.null (targettaxon)){
    targettaxon <- gsub(" ", "%20", sourcetaxon)
    for (i in 1:length (targettaxon)){
      requesturl <- paste (requesturl, "targetTaxon=", targettaxon[i], "&", sep="")
    }	
  }
	
  if (!is.null(bbox)){
    if (is.numeric(bbox) & length(bbox)==4){
			if (max (abs (bbox)) < 181 & bbox[1] <= bbox[3] & bbox[2] <= bbox[4]){
				requesturl <- paste (requesturl, "bbox=",bbox[1],",", 
					bbox[2],",", bbox[3],",", bbox[4], "&", sep="")
			} else {
				print ("Coordinates incorrect, returning all interactions")
			}} else({print ("Coordinates incorrect, returning all 
        interactions")})}

	if (returnobservations %in% c ("true", "false")){
		requesturl<-paste(requesturl, "includeObservations=", returnobservations, "&",
      sep="")
	}else {print("Incorrect entry for returnobservations, only distinct interactions 
    returned")}
		
	requesturltype <- paste (requesturl, "type=csv", sep="")
  requesteddata <- read.csv(requesturltype)	
	requesteddata
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
#' @examples
#' get_interactions_in_area(bbox=c(-67.87,12.79,-57.08,23.32))
get_interactions_in_area <- function(bbox){
  if (!is.null(bbox)){
    if (is.numeric(bbox) & length(bbox)==4){
	    if (max (abs (bbox)) < 181 & bbox[1] <= bbox[3] & bbox[2] <= bbox[4]){
	      requesturltype <- read.csv(paste(
          "http://api.globalbioticinteractions.org/interaction?bbox=",bbox[1],",", 
          bbox[2],",", bbox[3],",", bbox[4],"&type=csv", sep=""))
        requesturltype
	    }
    } else {
	      print ("Coordinates incorrect")
	    }
  }else({print("Coordinates incorrect")})
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
#' @examples
#' get_interaction_areas ()
#' get_interaction_areas (bbox=c(-67.87,12.79,-57.08,23.32))
get_interaction_areas <- function(bbox = NULL){
  requesturl <- read.csv ("http://api.globalbioticinteractions.org/locations?type=csv",
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
	      print ("Coordinates incorrect, returning all points in 10 s")
	      Sys.sleep(10)
	      requesturl
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
#' @examples
#' get_interaction_types()
get_interaction_types <- function(){
  requesttypes <- read.table("http://api.globalbioticinteractions.org/interactionTypes",header = F, sep="}",
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
