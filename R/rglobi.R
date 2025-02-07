
globi_api_url <- "api.globalbioticinteractions.org"

# Get GloBI Options

# @param opts list containing options
# @return list with options including default for missing options

add_missing_options <- function(opts, host = globi_api_url) {
  defaults <- list(host = host, port = 443)
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
  paste("https://", opts$host, ":", opts$port, suffix, sep = "")
}

# Check If Web API resolvable
#
# @return true if api is available, false otherwise 
has_api <- function() {
  !is.null(curl::nslookup(globi_api_url, error = FALSE))
}

# Read csv URL
# @param url points to csv resource
read_csv_online <- function(url, ...) {
    if (has_api()) {
      res <- suppressWarnings(suppressMessages(as.data.frame(readr::read_csv(url))))

      # Drop rows with all NAs
      res <- res[rowSums(is.na(res)) != ncol(res), ]

      return(res)
    }

    stop(paste("GloBI data services are not available at [", globi_api_url, "]. Are you connected to the internet?", sep = ""))
}

#' Get Species Interaction from GloBI
#'
#' @param taxon canonical scientific name of source taxon (e.g. Homo sapiens)
#' @param interaction.type the preferred interaction type (e.g. preysOn)
#' @param ... list of options to configure GloBI API
#' @return species interactions between source and target taxa
#' @family interactions
#' @export
#' @examples \donttest{
#' get_interactions("Homo sapiens", "preysOn")
#' get_interactions("Insecta", "parasiteOf")
#' }
get_interactions <- function(taxon = "Homo sapiens", interaction.type = "preysOn", ...) {
  get_interactions_by_taxa (sourcetaxon = taxon, interactiontype = interaction.type, ...)
}

#' Get Species Interactions by Interaction Type from GloBI
#'
#' @param interactiontype the requested interaction type (e.g. preysOn)
#' @param ... list of options to configure GloBI API
#' @return species interactions given provided interaction type(s)
#' @family interactions
#' @export
#' @examples \donttest{
#' get_interactions_by_type(interactiontype = c("eats", "eatenBy"))
#' get_interactions_by_type(interactiontype = "parasiteOf")
#' }
get_interactions_by_type <- function(interactiontype = c("interactsWith"), ...) {
  get_interactions_by_taxa (sourcetaxon = NULL, interactiontype = interactiontype, ...)
}

#' Get a List of Prey for given Predator Taxon
#'
#' @param taxon scientific name of predator taxon. Can be any taxonomic rank (e.g. Homo sapiens, Animalia)
#' @param ... list of named options to configure GloBI API
#' @return list of recorded predator-prey interactions that involve the desired predator taxon
#' @export
#' @family interactions
#' @examples \donttest{
#' get_prey_of("Homo sapiens")
#' get_prey_of("Primates")
#'}
get_prey_of <- function(taxon = "Homo sapiens", ...) {
  get_interactions(taxon, ...)
}

#' Get a List of Predators of a Given Prey Taxon
#'
#' @param taxon scientific name of prey taxon. Can be any taxonomic rank (e.g. Rattus rattus, Decapoda)
#' @param ... list of named options to configure the GloBI API
#' @return list of recorded prey-predator interactions that involve the desired prey taxon.
#' @export
#' @family interactions
#' @examples \donttest{
#' get_predators_of("Rattus rattus")
#' get_predators_of("Primates")
#' }
get_predators_of <- function(taxon = "Rattus rattus", ...) {
  get_interactions(taxon, "preyedUponBy", ...)
}

create_bbox_param <- function(bbox) {
  if (is.null(bbox)){
    "bbox="
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
#' @import RCurl
#' @param sourcetaxon Taxa of interest (consumer, predator, parasite); may be
#' specified as "Genus species" or higher level (e.g., Genus, Family, Class).
#' @param targettaxon Taxa of interest (prey, host); may be specified as "Genus
#' species" or higher level (e.g., Genus, Family, Class)
#' @param interactiontype Interaction types of interest (prey, host); may be
#' specified as listed by get_interaction_types()
#' @param accordingto Data source of interest
#' @param showfield Data fields of interest (e. g. source_taxon_external_id, source_taxon_name);
#' may be specified as listed by get_data_fields()
#' @param otherkeys list of key-value pairs to query any field not covered by other parameters;
#' keys may be specified as listed by get_data_fields()
#' @param bbox Coordinates in EPSG:4326 decimal degrees defining "left, bottom,
#'  right, top" of bounding box
#' @param returnobservations if true, all individual observations are returned,
#' else only distinct relationships
#' @param opts list of named options to configure GloBI API
#' @param read_csv function used to find csv associated to query url, defaulting to online query method
#' @return Returns data frame of interactions
#' @keywords database
#' @export
#' @note For data sources in which type of interactions were not specified, the interaction is labeled "interacts_with"
#' @family interactions
#' @examples \donttest{
#' get_interactions_by_taxa(sourcetaxon = "Rattus")
#' get_interactions_by_taxa(sourcetaxon = "Aves", targettaxon = "Rattus")
#' get_interactions_by_taxa(sourcetaxon = "Rattus rattus",
#' bbox = c(-67.87,12.79,-57.08,23.32))
#' }
get_interactions_by_taxa <- function(sourcetaxon, targettaxon = NULL, interactiontype = NULL, accordingto = NULL,
  showfield = c("source_taxon_external_id","source_taxon_name","source_taxon_path","source_specimen_life_stage","interaction_type","target_taxon_external_id","target_taxon_name","target_taxon_path","target_specimen_life_stage","latitude","longitude","study_citation","study_external_id","study_source_citation"),
  otherkeys = NULL, bbox = NULL, returnobservations = FALSE, opts = list(), read_csv = read_csv_online){
  if(length(interactiontype)>0){
    interactiontypes <- as.vector(get_interaction_types(read_csv = read_csv)[,1])
    if(length(intersect(interactiontypes, interactiontype)) == 0){
      stop ("Unsupported interaction type(s)")
    } else {
      if(length(intersect(interactiontypes, interactiontype)) < length(interactiontype)){
        warning (
          paste("Unsupported interaction type(s):", setdiff(interactiontype, interactiontypes))
        )
        interactiontype <- intersect(interactiontypes, interactiontype)
      }
    }
  }
  requesturlbase <- get_globi_url("/interaction?")
  if (!is.logical(returnobservations)) {
    warning ("Incorrect entry for 'returnobservations', using default value")
    returnobservations <- F
  }
  includeobservations <- paste ("includeObservations=", ifelse(returnobservations, "t", "f"), sep = "")
  requestsequence <- (function(
    keyvaluelist = append(
      list(
      "sourceTaxon" = sourcetaxon,
      "targetTaxon" = targettaxon,
      "interactionType" = interactiontype,
      "accordingTo" = accordingto,
      "field" = showfield
      ), otherkeys)
    ){
      paste(
      stats::na.omit(
          sapply(1:length(keyvaluelist), function(i){
          if(length(keyvaluelist[[i]])>0){
              paste(paste(names(keyvaluelist)[i], "=", RCurl::curlEscape(keyvaluelist[[i]]), sep = ""), collapse = "&")
            } else {
              NA
            }
          })
        ), collapse = "&")
  })()
  requesturl <- paste(requesturlbase, requestsequence, create_bbox_param(bbox), includeobservations, "type=csv", sep="&")
  result <- read_csv(requesturl)
  
  if(nrow(result) == 1024 & !"limit" %in% names(otherkeys)){
    warning("Default results limit reached. Consider increasing limit parameter and/or using pagination to retrieve all results. See rglobi vignette section on pagination for help modifying limit/skip parameters.")
  }

  return(result)
  
}


#' @title Return all interactions in specified area
#'
#' @description Returns all interactions in data base in area specified in
#' arguments
#'
#' @param bbox Coordinates in EPSG:4326 decimal degrees defining "left, bottom,
#' right, top" of bounding box
#' @param ... list of named options to configure GloBI API
#' @return Returns data frame of interactions
#' @keywords database
#' @export
#' @family areas
#' @examples \donttest{
#' get_interactions_in_area(bbox = c(-67.87, 12.79, -57.08, 23.32))
#' }
get_interactions_in_area <- function(bbox, ...){
  if (is.null(bbox)) {
    stop("no coordinates provided")
  } else {
    get_interactions_by_taxa (sourcetaxon = NULL, bbox = bbox, ...)
  }
}

#' @title Find locations at which interactions were observed
#'
#' @description Returns all locations (latitude,longitude) of interactions in data
#' base or area specified in arguments
#'
#' @param bbox Coordinates in EPSG:4326 decimal degrees defining "left, bottom,
#' right, top" of bounding box
#' @param ... list of named options to configure GloBI API
#' @param read_csv function used to find csv associated to query url, defaulting to online query method
#' @return Returns data frame of coordinates
#' @keywords database
#' @export
#' @family areas
#' @examplesIf interactive()
#' get_interaction_areas ()
#' get_interaction_areas (bbox=c(-67.87,12.79,-57.08,23.32))
get_interaction_areas <- function(bbox = NULL, read_csv = read_csv_online, ...){
  requesturl <- read_csv (get_globi_url("/locations?type=csv", ...))
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
#' @param opts list of named options to configure GloBI API
#' @param read_csv function used to find csv associated to query url, defaulting to online query method
#' @return Returns data frame of supported interaction types
#' @keywords database
#' @export
#' @family interactions
#' @examples \donttest{
#' get_interaction_types()
#' }
get_interaction_types <- function(opts = list(), read_csv = read_csv_online) {
  read_csv(get_globi_url("/interactionTypes.csv?type=csv", opts = opts))
}

#' @title List data fields identified in GloBI database
#'
#' @description Returns data frame with supported data fields
#'
#' @param opts list of named options to configure GloBI API
#' @param read_csv function used to find csv associated to query url, defaulting to online query method
#' @return Returns data frame of supported data fields
#' @keywords database
#' @export
#' @family data
#' @examples \donttest{
#' get_data_fields()
#' }
get_data_fields <- function(opts = list(), read_csv = read_csv_online) {
  read_csv(get_globi_url("/interactionFields.csv?type=csv", opts = opts))
}

# Generate Diet Matrices using https://github.com/ropensci/rglobi
#
# To install:
# (a) install devtools using install.packages('devtools')
# (b) install rglobi using devtools::install_github('rglobi', 'ropensci')
# (c) load the contents of this gist into R using devtools::source_url('https://gist.githubusercontent.com/jhpoelen/81b4eced3963633b96cb/raw/dietMatrix.R')
#
# Examples
#
# Create a diet matrix for humans (Homo sapiens) and old world rat (Rattus rattus) using prey categories Aves and Mammalia:
# CreateDietMatrix(c('Homo sapiens', 'Rattus rattus'), c('Aves', 'Mammalia'))
#
# Example 1. Create a diet matrix of first 25 predator species taxa using Haydens Diet Category list (see defaults in GetPreyCategories()):
#
# diet.matrix <- CreateDietMatrix(GetPredatorTaxa(limit=25))
#
#
# Example 2. Same as example 1. except that port [1234] is used to query. This can be used to run queries again something
# other (e.g. Dark GloBI) than the default, open, GloBI instance. Note that port [1234] will have to be replaced with a
# valid port value in order for it to work.
#
# opts <- list(port=1234)
# predator.taxa <- GetPredatorTaxa(limit=25, opts=opts)
# diet.matrix <- CreateDietMatrix(predator.taxa, opts = opts)
#
# Result is a data frame with predator taxon name and food categories as columns and predator taxon occurrences as rows.
#

ReportProgress <- function() {
  message('.', appendLF=FALSE)
}

rel_type_interaction_type <- function(interaction.type) {
  list(preysOn = 'ATE|PREYS_UPON',
    parasiteOf = 'PARASITE_OF',
    pollinates = 'POLLINATES')[[interaction.type]]
}

# Retrieves diet items of given predator and classifies them by matching the prey categories against
# both taxon hierarchy of prey and the name that was originally used to describe the prey.
unique_target_taxa_of_source_taxon <- function(source.taxon.name, target.taxon.names, interaction.type, opts = list(), read_csv = read_csv_online) {
  result <- get_interactions_by_taxa(sourcetaxon = source.taxon.name, interactiontype = interaction.type, targettaxon = target.taxon.names, opts = opts, read_csv = read_csv) 
  ReportProgress()
  all.taxa.paths <- Reduce(function(accum, path) paste(accum, path), paste('{',result$target_taxon_path,'}', sep=''))
  has.prey.category <- lapply(target.taxon.names, function(prey.category) {
    match <- grep(prey.category, all.taxa.paths, perl=TRUE)
    ifelse(length(match) > 0, 1, 0)
  })
  df <- data.frame(t(c(source.taxon.name, has.prey.category)))
  names(df) <- c('source.taxon.name', target.taxon.names)
  df
}



#' Get Interaction Matrix. Constructs an interaction matrix indicating whether source taxa (rows) or target taxa (columns) are known to interact with given type.
#'
#' @param source.taxon.names list of source taxon names (e.g. list('Mammalia', 'Aves', 'Ariopsis felis'))
#' @param target.taxon.names list of target taxon names
#' @param interaction.type the preferred interaction type (e.g. preysOn)
#' @param opts list of options to configure GloBI API
#' @param read_csv function used to find csv associated to query url, defaulting to online query method
#' @return matrix representing species interactions between source and target taxa
#' @family interactions
#' @export
#' @examples \donttest{
#' get_interaction_matrix("Homo sapiens", "Mammalia", "interactsWith")
#' }
get_interaction_matrix <- function(source.taxon.names = list('Homo sapiens'), target.taxon.names = list('Mammalia'), interaction.type = 'eats', opts = list(), read_csv = read_csv_online) {
  Reduce(function(accum, source.taxon.name) rbind(accum, unique_target_taxa_of_source_taxon(source.taxon.name, target.taxon.names, interaction.type, opts = opts, read_csv = read_csv)), source.taxon.names, init=data.frame())
}

interaction_id_for_type <- function(interaction.type) {
  list(preysOn = 'RO_0002439', parasiteOf = 'RO_0002444', pollinates = 'RO_0002455')[[interaction.type]]
}
