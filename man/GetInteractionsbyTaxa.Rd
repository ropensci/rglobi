\name{GetInteractionsbyTaxa}
\alias{GetInteractionsbyTaxa}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Return interactions involving specific taxa
}
\description{
Returns interactions involving specific taxa.  Secondary (target) taxa and spatial boundaries may also be sets
}
\usage{
GetInteractionsbyTaxa(sourcetaxon, targettaxon = NULL, bbox = NULL, returnobservations = "false")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sourcetaxon}{Taxa of interest (consumer, predator, parasite); may be specified as "Genus species" or higher level (e.g., Genus, Family, Class).}
  \item{targettaxon}{Taxa of interest (prey, host); may be specified as "Genus species" or higher level (e.g., Genus, Family, Class)}
  \item{bbox}{Coordinates in EPSG:4326 decimal degrees defining "left, bottom, right, top" of bounding box}
  \item{returnobservations}{if true, all individual observations are returned, else only distinct relationships}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
Returns data frame of interactions

}
\references{
%% ~put references to the literature/web site here ~
}
\author{
J. Stephen Gosnell, stephengosnell@gmail.com
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
GetInteractionsbyTaxa(sourcetaxon="Rattus")
GetInteractionsbyTaxa(sourcetaxon="Rattus rattus", targettaxon="Aves")
GetInteractionsbyTaxa(sourcetaxon="Rattus rattus", bbox=c(-67.87,12.79,-57.08,23.32))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ database }
