Dear Reviewers:

I build this package using [R CMD build .] and checked is with command [R CMD check --as-cran rglobi_0.2.6.tar.gz] on my Mac OS X (v 10.9.5) machine running R  3.1.3 . Also, the checks were executed on travis-ci.org (running Ubuntu) and winbuilder (running windows). 

Fixes:
* Previously, all trophic interaction where described using "preysOn". Now, trophic types are described by "eats" in addition to "preysOn". This allows for making the distinction between eating a leaf and hunting and killing an animal. Changes include updated test assumptions following an API change. 

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
