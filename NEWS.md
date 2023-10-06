# rglobi 0.3.4
 * changed package title to omit the leading "R" - from "R Interface to ..." to "Interface to ..."
 * for boolean defaults, use "= TRUE" style, instead of shorthand "= T" 
 * replaced wrapped examples from "dontrun{}" to "donttest{}" 

# rglobi 0.3.3
 * Change http://ropensci.org/packages to https://reopensci.org/packages/ to address a "note" due to 403 forbidden and a 301 redirect.

# rglobi 0.3.2
 * Change https://globalbioticinteractions.org to https://www.globalbioticinteractions.org to address a "note" due to 301 redirect.

# rglobi 0.3.1
 * Remove travis-ci badge in README.md that caused a "note" due to 301 redirect.
 * Remove references to Cypher query support in vignettes.

# rglobi 0.3.0
 * Removing support for directly executing Cypher queries: cypher queries are open ended, caused intermittent test errors, and subject to change in future neo4j upgrades. 

# rglobi 0.2.28

 * Adding warning message when query generates more results than can be returned. Big thanks for Helen Waters for their contributions @H-Waters https://github.com/H-Waters via https://github.com/ropensci/# rglobi/pull/45
 
  * update NEWS format

# rglobi 0.2.27

 * improve test cases to skip with message if web apis are unavailable

# rglobi 0.2.26

  * improve test cases to include error handling

# rglobi 0.2.25

  * added section on returnobservations=T in getting started vignette as suggested by @ZekeMarshall in https://github.com/ropensci/# rglobi/issues/38#issuecomment-897603331 .

# rglobi 0.2.24

  * replace broken url http://spatialreference.org/ref/epsg/wgs-84/ with https://en.wikipedia.org/wiki/World_Geodetic_System .

# rglobi 0.2.23

  * minor changes by @jimhester (thanks Jim!) to prepare for readr 2.0.0 release via https://github.com/ropensci/# rglobi/pull/37 .

# rglobi 0.2.22

  * include markdown in DESCRIPTION suggests list as instructed in https://github.com/yihui/knitr/issues/1864
  * update urls as suggested by cran release checks
  * exclude .github workflow directory from R build

# rglobi 0.2.21

  * use query cache for unit tests to make tests less dependent of state of online api

# rglobi 0.2.20

  * Use readr package to handle incoming csv streams to help avoid encoding issues on Windows . Also see https://github.com/ropensci/# rglobi/issues/33 .
  * remove debug messages
  * updates reference to https://github.com/globalbioticinteractions/globalbioticinteractions after repo migration from https://github.com/jhpoelen/eol-globi-data . 

# rglobi 0.2.19

  * show informative messages like ```GloBI data services are not available at [api.globalbioticinteractions.org]. Are you connected to the internet?``` when internet resources are not available. Suggested by Brian D. Ripley . Also see https://github.com/ropensci/# rglobi/issues/31 .

# rglobi 0.2.18

  * Update cypher query endpoint after server upgrade to neo4j v2.3.12

# rglobi 0.2.17

  * Use utils::download.file in an attempt to avoid intermittent download issues on debian.  

# rglobi 0.2.16

  * Enforce utf-8 encoding when reading csv, take 2. 

# rglobi 0.2.15

  * Enforce utf-8 encoding when reading csv. 

# rglobi 0.2.14

  * Fix yet another test error caused by overly restrictive assertion.

# rglobi 0.2.13

  * Fix another test error caused by overly restrictive assertion.

# rglobi 0.2.12

  * Fix test error caused by overly restrictive assertion.

# rglobi 0.2.11

  * After switching to https endpoint for GloBI APIs, the default configuration needed updating to ensure existing functions to continue to work.

# rglobi 0.2.10

  * a rglobi user requested to search by interactions type (see https://github.com/ropensci/# rglobi/issues/23). The functionality was implemented by adding method ```get_interactions_by_type```.

 * a rglobi user requested to search by interactions type (see https://github.com/ropensci/# rglobi/issues/23). The functionality was implemented by adding method ```get_interactions_by_type```.

# rglobi 0.2.9

  * make get_interaction_matrix use same name matching method as get_interactions . See https://github.com/globalbioticinteractions/globalbioticinteractions.github.io/issues/63 .

# rglobi 0.2.8

  * Switch neo4j port from 7474 to 80 following changes to the neo4j endpoint.
