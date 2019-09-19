Dear Reviewers:

I built this package using [R CMD build .] and checked it with command [R CMD check --as-cran rglobi_0.2.20.tar.gz] on my Ubuntu 18.04 LTS Bionic Beaver (4.15.0-55-generic) machine running R 3.6.1 . Also, the checks were executed on travis-ci.org (running Ubuntu) and winbuilder (running windows). 

IMPROVEMENT
* Use readr package to handle incoming csv streams to help avoid encoding issues on Windows . Also see https://github.com/ropensci/rglobi/issues/33 .
* remove debug messages
* updates reference to https://github.com/globalbioticinteractions/globalbioticinteractions after repo migration from https://github.com/jhpoelen/eol-globi-data . 

The remaining note for this version is:

Possibly mis-spelled words in DESCRIPTION:
  Biotic (3:30, 5:24)
  Cypher (9:46)
  GloBI (5:45, 5:53, 10:60)
  rglobi (7:33)

I've checked the mis-spelled words and confirmed that they are in fact not mis-spelled. 

Thank you for taking the time to review my submission.

-jorrit
