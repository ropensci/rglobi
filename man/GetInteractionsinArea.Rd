\name{GetInteractionsinArea}
\alias{GetInteractionsinArea}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Return all interactions in noted area
}
\description{
Returns all interactions in data base in area specified in arguments
}
\usage{
GetInteractionsinArea(bbox)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{bbox}{Coordinates in EPSG:4326 decimal degrees defining "left, bottom, right, top" of bounding box}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
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
GetInteractionsinArea(bbox=c(-67.87,12.79,-57.08,23.32))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ database }
