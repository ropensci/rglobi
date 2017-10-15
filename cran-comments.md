Dear Reviewers:

I built this package using [R CMD build .] and checked it with command [R CMD check --as-cran rglobi_0.2.11.tar.gz] on my Ubuntu 16.04 LTS Xenial (4.4.0-93-generic) machine running R 3.4.2 . Also, the checks were executed on travis-ci.org (running Ubuntu) and winbuilder (running windows). 

Bug fix:
* After switching to https endpoint for GloBI APIs, the default configuration needed updating to ensure existing functions to continue to work.

The remaining note for this version is:
* checking CRAN incoming feasibility ... NOTE
Maintainer: ‘Jorrit Poelen <jhpoelen@xs4all.nl>’
Components with restrictions and base license permitting such:
  MIT + file LICENSE
File 'LICENSE':
  YEAR: 2017
  COPYRIGHT HOLDER: Jorrit Poelen

Thank you for taking the time to review my submission.

-jorrit
