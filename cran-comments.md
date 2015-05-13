Dear Reviewers:

I build this package using [R CMD build .] and checked is with command [R CMD check --as-cran rglobi_0.2.7.tar.gz] on my Mac OS X (v 10.9.5) machine running R 3.2.0 . Also, the checks were executed on travis-ci.org (running Ubuntu) and winbuilder (running windows). 

Fixes:
* a domain name change caused a failure in some of the query tests, despite the implementation of a http redirect. Now, the new neo4j subdomain is used (e.g. http://neo4j.globalbioticinteractions.org instead of http://api.globalbioticinteractions.org:7474).

The remaining note for this version is:
* checking CRAN incoming feasibility ... NOTE
Maintainer: ‘Jorrit Poelen <jhpoelen@xs4all.nl>’
Components with restrictions and base license permitting such:
  MIT + file LICENSE
File 'LICENSE':
  YEAR: 2015
  COPYRIGHT HOLDER: Jorrit Poelen

Thank you for taking the time to review my submission.

-jorrit
