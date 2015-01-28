Dear Reviewers:

I build this package using [R CMD build .] and checked is with command [R CMD check --as-cran rglobi_0.2.3.tar.gz] on my Mac OS X (v 10.9.5) machine running R  3.1.2 . Also, the checks were executed on travis-ci.org (running Ubuntu) and winbuilder (running windows). I found no errors, but did observe the following note:

* checking CRAN incoming feasibility ... NOTE
Maintainer: ‘Jorrit Poelen <jhpoelen@xs4all.nl>’
New submission
Components with restrictions and base license permitting such:
  MIT + file LICENSE
File 'LICENSE':
  YEAR: 2015
  COPYRIGHT HOLDER: Jorrit Poelen
Package has a VignetteBuilder field but no prebuilt vignette index.

Thank you for taking the time to review my submission.

-jorrit

PS Please note that initially, I attempted to submit the package v0.2.2 using the devtools::release command. However, after learning that this is not supported, I reverted to the official submit page I am using now.