% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rglobi.R
\name{get_interactions}
\alias{get_interactions}
\title{Get Species Interaction from GloBI}
\usage{
get_interactions(taxon = "Homo sapiens", interaction.type = "preysOn", ...)
}
\arguments{
\item{taxon}{canonical scientific name of source taxon (e.g. Homo sapiens)}

\item{interaction.type}{the preferred interaction type (e.g. preysOn)}

\item{...}{list of options to configure GloBI API}
}
\value{
species interactions between source and target taxa
}
\description{
Get Species Interaction from GloBI
}
\examples{
\donttest{
get_interactions("Homo sapiens", "preysOn")
get_interactions("Insecta", "parasiteOf")
}
}
\seealso{
Other interactions: 
\code{\link{get_interaction_matrix}()},
\code{\link{get_interaction_types}()},
\code{\link{get_interactions_by_taxa}()},
\code{\link{get_interactions_by_type}()},
\code{\link{get_predators_of}()},
\code{\link{get_prey_of}()}
}
\concept{interactions}
