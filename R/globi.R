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

GetInteractions <- function(sourcetaxon, targettaxon=NULL, type = NULL, bbox=NULL, ) {
	taxon=gsub(" ", "%20", taxon)
	if (taxon != NULL){
  a=read.csv(paste("http://api.globalbioticinteractions.org/interactions?", 


Homo%20sapiens/preysOn?type=csv)))

http://api.globalbioticinteractions.org/interaction?bbox=-67.87,12.79,-57.08,23.32&sourceTaxon=Actinopterygii&targetTaxon=Arthropoda
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
  #a=read.csv(a)	
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
		a=a[a$Latitude>=bbox[1] & a$Latitude<=bbox[3] & a$Longitude>=bbox[2] & a$Longitude<=bbox[4], ]
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