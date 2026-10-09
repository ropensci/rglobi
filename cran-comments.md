Dear Reviewers:

This is a resubmission of rglobi, which was archived on 2026-09-16 because the "donttest" additional check failed: the example of get_data_fields() stopped with "cannot open the connection" (https://www.stats.ox.ac.uk/pub/bdr/donttest/rglobi.out).

I built this package using [R CMD build .] and checked it with command [R CMD check --as-cran --run-donttest rglobi_0.3.5.tar.gz].

FIXES
 * all functions now fail gracefully, with an informative message and a NULL return value, when the GloBI web services cannot be reached or return an HTTP error (CRAN policy on Internet resources). Previously only DNS resolution was checked, so HTTP errors surfaced as R errors.
 * get_data_fields() now uses the /interactionFields endpoint, as /interactionFields.csv started returning HTTP 404.
 * replaced the broken vignette link https://spatialreference.org/ref/epsg/wgs-84/ (HTTP 404) with https://spatialreference.org/ref/epsg/4326/.
 * new offline tests check that each function returns NULL with a message when the web service is unavailable.

I've checked the mis-spelled words and confirmed that they are in fact not mis-spelled.

Thank you for taking the time to review my submission.

-jorrit
