cached_filename = function(url) {
  url_sha256 <- openssl::sha256(url)
  paste('cache/', url_sha256, sep='')
}

read_csv_caching = function(url, ...) {
  x = cached_filename(url)
  r <- httr::GET(url)
  some_response <- httr::content(r, type = "text", encoding = "UTF-8")
  write(some_response, file = x)
  as.data.frame(readr::read_csv(x))
}

read_csv_offline = function(url, ...) {
  readr::read_csv(cached_filename(url))
}

