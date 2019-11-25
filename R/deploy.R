#' Deploy on shinyapps.io
#' @export
deploy <- function() {
  deployApp(appDir = system.file("chart", package = "jamestest"),
            appTitle =  "JAMES tryout",
            account = "tnochildhealthstatistics")
}
