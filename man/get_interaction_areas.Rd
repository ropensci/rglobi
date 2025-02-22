% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rglobi.R
\name{get_interaction_areas}
\alias{get_interaction_areas}
\title{Find locations at which interactions were observed}
\usage{
get_interaction_areas(bbox = NULL, read_csv = read_csv_online, ...)
}
\arguments{
\item{bbox}{Coordinates in EPSG:4326 decimal degrees defining "left, bottom,
right, top" of bounding box}

\item{read_csv}{function used to find csv associated to query url, defaulting to online query method}

\item{...}{list of named options to configure GloBI API}
}
\value{
Returns data frame of coordinates
}
\description{
Returns all locations (latitude,longitude) of interactions in data
base or area specified in arguments
}
\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
get_interaction_areas ()
get_interaction_areas (bbox=c(-67.87,12.79,-57.08,23.32))
\dontshow{\}) # examplesIf}
}
\seealso{
Other areas: 
\code{\link{get_interactions_in_area}()}
}
\concept{areas}
\keyword{database}
