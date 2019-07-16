#' Constructs and plots the A4 growth chart
#'
#' This function function the chart on the currently open device
#' @param ind An S4 object of class \code{individual} containing data of the individual
#' @param chartcode A string with chart code
#' @param curve_interpolation A logical indicating whether curve interpolation shoud be applied.
#' @param quiet Logical indicating whether chart code should be written
#' to standard output. Default is \code{quiet = TRUE}.
#' @return A grid object
#' @export
draw_plot <- function(ind, chartcode, curve_interpolation = TRUE,
                      quiet = TRUE) {

  g <- load_chart(chartcode)
  if (is.null(g) || !is.grob(g)) return(placeholder(name = chartcode))

  # set palette
  parsed <- parse_chartcode(chartcode)
  old_pal <- palette(chartbox::palettes[parsed$population, ])

  # set data points
  if (!quiet) cat("chartcode: ", chartcode, "\n")
  g <- set_curves(g, ind, curve_interpolation)

  # draw
  grid.draw(g)

  palette(old_pal)
  invisible(g)
}
