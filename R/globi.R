GetGloBIURL <- function(suffix) {
  paste("http://api.globalbioticinteractions.org", suffix, sep = "")
}

#' Get Species Interaction from GloBI 
#'
#' @param taxon canonical scientic name of source taxon (e.g. Homo sapiens) 
#' @param interactionType the preferred interaction type (e.g. preysOn)
#' @return species interactions between source and target taxa 
#' @export
#' @examples
#' GetInteractions("Homo sapiens", "preysOn")
#' GetInteractions("Insecta", "parasiteOf")
GetInteractions <- function(taxon = "Homo sapiens", interactionType = "preysOn") {
  query <- paste("/taxon/", RCurl::curlEscape(taxon), "/", interactionType, "?type=csv", sep="") 
  requestURL = GetGloBIURL(query)
  read.csv(text = httr::content(httr::GET(requestURL)))
}

#' Get a List of Prey for given Predator Taxon 
#'
#' @param taxon scientific name of predator taxon. Can be any taxonomic rank (e.g. Homo sapiens, Animalia)
#' @return list of recorded predator-prey interactions that involve the desired predator taxon
#' @examples
#' GetPreyOf("Homo sapiens")
#' GetPreyOf("Primates")
GetPreyOf <- function(taxon = "Homo sapiens") {
  GetInteractions(taxon)
}

#' Get a List of Predators of a Given Prey Taxon
#'
#' @param taxon scientific name of prey taxon. Can be any taxonomic rank (e.g. Rattus rattus, Decapoda)
#' @return list of recorded prey-predator interactions that involve the desired prey taxon.
#' @examples
#' GetPredatorsOf("Rattus rattus")
#' GetPredatorsOf("Primates")
GetPredatorsOf <- function(taxon = "Rattus rattus") {
  GetInteractions(taxon, "preyedUponBy")
}

#' Executes a Cypher Query Against GloBI's Neo4j Instance
#' 
#' @param querystring Cypher query (see http://github.com/jhpoelen/eol-globi-data/wiki/cypher for examples)
#' @return result of cypher query string 
Query <- function(cypherQuery) {
  h <- RCurl::basicTextGatherer()

  RCurl::curlPerform(
    url=GetGloBIURL(":7474/db/data/ext/CypherPlugin/graphdb/execute_query"),
    postfields=paste('query',RCurl::curlEscape(cypherQuery), sep='='),
		writefunction = h$update,
		verbose = FALSE
  )
  result <- rjson::fromJSON(h$value())
  data <- data.frame(t(sapply(result$data, unlist)))
  names(data) <- result$columns
  data
}

GetInteractionsbyTaxa <- function(sourcetaxon, targettaxon=NULL, bbox=NULL, returnobservations="false"){
sourcetaxon=gsub(" ", "%20", sourcetaxon)
a="http://api.globalbioticinteractions.org/interaction?"	
	for (i in 1:length(sourcetaxon)){
	a=paste(a, "sourceTaxon=",sourcetaxon[i], "&", sep="")
	}
	
	if (!is.null(targettaxon)){
	sourcetaxon=gsub(" ", "%20", sourcetaxon)
	for (i in 1:length(targettaxon)){
	a=paste(a, "targetTaxon=", targettaxon[i], "&", sep="")
	}	
	}
	
	if (!is.null(bbox)){
			if(is.numeric(bbox) & length(bbox)==4){
						if (max(abs(bbox))<181 & bbox[1]<=bbox[3] & bbox[2]<=bbox[4]){
							a=paste(a, "bbox=",bbox[1],",", 
							bbox[2],",", bbox[3],",", bbox[4], "&", sep="")
						}else {
					print ("Coordinates incorrect, returning all interactions")
				}}else({print("Coordinates incorrect, returning all interactions")})}

	if (returnobservations %in% c("true", "false")){
		a=paste(a, "includeObservations=", returnobservations, "&", sep="")
	}else {print("Incorrect entry for returnobservations, only distinct interactions returned")}
		
	a=paste (a, "type=csv", sep="")
  a=read.csv(a)	
	a
	}	

GetInteractionsinArea <- function(bbox){
if(!is.null(bbox)){
if(is.numeric(bbox) & length(bbox)==4){
	if (max(abs(bbox))<181 & bbox[1]<=bbox[3] & bbox[2]<=bbox[4]){
	
a=read.csv(paste("http://api.globalbioticinteractions.org/interaction?bbox=",bbox[1],",", 
	bbox[2],",", bbox[3],",", bbox[4],"&type=csv", sep=""))
a
	
}}else {
	print ("Coordinates incorrect")
	}
}else({print("Coordinates incorrect")})
}

GetInteractionAreas <- function(bbox=NULL){
a=read.csv("http://api.globalbioticinteractions.org/locations?type=csv")
names(a)=c("Latitude", "Longitude")	
	
if(!is.null(bbox)){
if(is.numeric(bbox) & length(bbox)==4)
	{if (max(abs(bbox))<181 & bbox[1]<=bbox[3] & bbox[2]<=bbox[4]){
		a=a[a$Latitude>=bbox[2] & a$Latitude<=bbox[4] & a$Longitude>=bbox[1] & a$Longitude<=bbox[3], ]
	return(a)
	}}
else {
	print ("Coordinates incorrect, returning all points in 10 s")
	Sys.sleep(10)
	a
	}
}
	else {a}
}

GetInteractionTypes <- function(){
a=read.table("http://api.globalbioticinteractions.org/interactionTypes",header=F, sep="}",
	 stringsAsFactors = F, strip.white=T)
a=t(a)
a=gsub("[{} ]", "", a)
a=gsub("^,", "", a)
a=sub("source:" ,"", a)
a=sub("target:" ,"", a)
a=sub(":" ,",", a)
a=a[!is.na(a)]
a=matrix(unlist(strsplit(a,",")), ncol=3, byrow=T)
a=data.frame(a)
names(a)=c("Interaction", "Source", 'Target')
return(a)
}
