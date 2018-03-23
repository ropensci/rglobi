Dear Reviewers:

I built this package using [R CMD build .] and checked it with command [R CMD check --as-cran rglobi_0.2.14.tar.gz] on my Ubuntu 16.04 LTS Xenial (4.4.0-112-generic) machine running R 3.4.4 . Also, the checks were executed on travis-ci.org (running Ubuntu) and winbuilder (running windows). 

Bug fix:
* Fix yet another test error caused by overly restrictive assertion.

The remaining warning for this version is:
* checking top-level files ... WARNING
Conversion of ‘README.md’ failed:
pandoc: Could not fetch https://cranlogs.r-pkg.org/badges/rglobi?color=E664A4
TlsExceptionHostPort (HandshakeFailed Error_EOF) "cranlogs.r-pkg.org" 443

I've checked this badge url in a browser and it rendered just fine. I am assuming this warning is not critical. 

Thank you for taking the time to review my submission.

-jorrit
