#' Deploy on shinyapps.io
#'
#' @export
deploy <- function() {
  cat("Before you do this, use devtools::install_github('growthcharts/pkg') with pkg all dependencies.\n" )
  deployApp(appDir = system.file("chart", package = "jamesdemo"),
            appTitle =  "JAMES tryout",
            account = "tnochildhealthstatistics")
}
