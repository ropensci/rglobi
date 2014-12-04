rglobi
=======
[![Build Status](https://travis-ci.org/ropensci/rglobi.svg?branch=master)](https://travis-ci.org/ropensci/rglobi)

Pre-alpha!

R library to access species interaction data of http://globalbioticinteractions.org

To install:
```R
install.packages("devtools")
devtools::install_github("ropensci/rglobi")
```

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

Vignettes are generated using knitr and markdown packages, using a recipe like:

```R
install.packages(c('knitr','markdown'))
require('knitr')
require('markdown')
knit('vignettes/vignette.Rmd', 'vignettes/vignette.md')
markdownToHTML('vignettes/vignette.md', 'vignettes/vignette.html', options=c("use_xhtml"))
```

## Meta

Please [report any issues or bugs](https://github.com/ropensci/rglobi/issues).

This package is part of the [rOpenSci](http://ropensci.org/packages) project.

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
