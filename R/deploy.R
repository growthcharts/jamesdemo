#' Deploy on shinyapps.io
#'
#' @export
deploy <- function() {
  deployApp(appDir = system.file("chart", package = "jamesdemo"),
            appTitle =  "JAMES tryout",
            account = "tnochildhealthstatistics")
}
