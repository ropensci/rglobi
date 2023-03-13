
calc_content_id = function(txt) {
  digest::digest(txt, algo="sha256", serialize=F)
}

cached_filename = function(url) {
  paste('cache/', calc_content_id(url), sep='')
}

read_csv_caching = function(url, ...) {
  x = cached_filename(url)
  r <- httr::GET(url)
  some_response <- httr::content(r, type = "text", encoding = "UTF-8")
  write(some_response, file = x)
  as.data.frame(readr::read_csv(x))
}

read_csv_offline = function(url, ...) {
  res <- suppressWarnings(suppressMessages(as.data.frame(readr::read_csv(cached_filename(url), progress = FALSE))))

  # Drop rows with all NAs
  res <- res[rowSums(is.na(res)) != ncol(res), ]

  res
}
