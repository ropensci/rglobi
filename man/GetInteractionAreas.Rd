\name{GetInteractionAreas}
\alias{GetInteractionAreas}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Find locations at which interactions were observed
}
\description{
Returns all locations (latitude,longitude) of interactions in data base or area specified in arguments}
\usage{
GetInteractionAreas(bbox = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{bbox}{
 Coordinates in EPSG:4326 decimal degrees defining "left, bottom, right, top" of bounding box}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Returns data frame of coordinates
}

\author{
J. Stephen Gosnell, stephengosnell@gmail.com}

\examples{
GetInteractionAreas()
GetInteractionAreas(bbox=c(-67.87,12.79,-57.08,23.32))
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ database }
