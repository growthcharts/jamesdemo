#' Deploy on shinyapps.io
#' @export
deploy <- function() {
  deployApp(appDir = file.path(path.package(package = "jamestest"), "chart"),
            appTitle =  "JAMES tryout",
            account = "tnochildhealthstatistics")
}
