
=======
[![Build Status](https://travis-ci.org/ropensci/rglobi.svg?branch=master)](https://travis-ci.org/ropensci/rglobi)

[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rglobi?color=E664A4)](https://github.com/metacran/cranlogs.app)

[![cran version](http://www.r-pkg.org/badges/version/rglobi)](http://cran.rstudio.com/web/packages/rglobi)


R library to access species interaction data of http://globalbioticinteractions.org

To install ```rglobi``` from [CRAN](http://cran.r-project.org/web/packages/rglobi/):
```R
install.packages("rglobi")
```

Or install development version:
```R
install.packages("devtools")
devtools::install_github("ropensci/rglobi")
```

## Getting Data

```R
library(rglobi)
# find all unique prey names of Homo sapiens
prey_of("Homo sapiens")$target_taxon_name
# is a shortcut of
get_interactions_by_taxa(sourcetaxon='Homo sapiens', interactiontype='preysOn')$target_taxon_name

# list of supported interactions types
get_interaction_types()

# all known prey names and locations (latitude, longitude) where birds (Aves) preyed on rodents (Rodentia) in California
obs <- get_interactions_by_taxa(sourcetaxon = "Aves", bbox=c(-125.53344800000002,32.750323,-114.74487299999998,41.574361), targettaxon = "Rodentia", returnobservations=T)
locations <- cbind(obs$target_taxon_name, obs$latitude, obs$longitude)
```
Please see R help pages (e.g. ```?get_interactions_by_taxa``` and [vignettes](http://cran.r-project.org/web/packages/rglobi/) for more information.

## Tests
Tests can be executed using devtools package.
```R
# workdir should be rglobi repo root directory (check with getwd())
devtools::test()
```
This should reload the library, executes the test_that testcases and show test reports.

## Documentation
roxygen2 is used to generate .Rd and NAMESPACE by running:
```R
 library(roxygen2)
 roxygenize(".")
```

Vignettes are generated using ```knitr``` and ```markdown``` packages.

## Meta

Please [report any issues or bugs](https://github.com/ropensci/rglobi/issues).

This package is part of the [rOpenSci](http://ropensci.org/packages) project.

[![rOpenSci footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
