Dear Reviewers:

I built this package using [R CMD build .] and checked it with command [R CMD check --as-cran rglobi_0.2.9.tar.gz] on my Mac OS X (v 10.11.3) machine running R 3.2.3 . Also, the checks were executed on travis-ci.org (running Ubuntu) and winbuilder (running windows). 

Fixes:
* a rglobi user notices a discrepancy in name matching between get_interaction_matrix and get_interactions methods (see https://github.com/globalbioticinteractions/globalbioticinteractions.github.io/issues/63). The fix included in this version now makes sure that the get_interaction_matrix and get_interactions method use the same name matching method. 

The remaining note for this version is:
* checking CRAN incoming feasibility ... NOTE
Maintainer: ‘Jorrit Poelen <jhpoelen@xs4all.nl>’
Components with restrictions and base license permitting such:
  MIT + file LICENSE
File 'LICENSE':
  YEAR: 2016
  COPYRIGHT HOLDER: Jorrit Poelen

Thank you for taking the time to review my submission.

-jorrit
