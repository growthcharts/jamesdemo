
host <- "http://james.groeidiagrammen.nl"
host <- "https://groeidiagrammen.nl"
path <- "ocpu/library/james"

fn <- system.file("extdata", "bds_v1.0", "smocc", "Laura_S.json", package = "jamesdemodata")
bds <- readLines(fn)

r <- jamesclient::james_post(host = host,
                             sitehost = host,
                             path = file.path(path, "R/request_site/json"),
                             txt = bds)

urlm <- file.path(host, headers(r)$`x-ocpu-session`, "messages")
