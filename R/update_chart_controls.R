#' Update the user interface when a new chart is selected
#'
#' This function updates chart controls given the chart code.
#' The function updates the age group setting, the side radio button,
#' the etnicity, week and sex interface elements.
#' @aliases update_chart_controls
#' @param session Shiny session object
#' @param chartgrp  The chart group: \code{'nl2010'}, \code{'preterm'}, \code{'who'}
#' or \code{character(0)}
#' @param chartcode The chart code
#' @param ga Optionally, gestional age (weeks) for setting week slider
#'  for non-preterms
#' @return This function is called for its side effects
#' @export
update_chart_controls <- function(session, chartgrp, chartcode, ga = NULL) {

  # update age grp setting
  parsed <- parse_chartcode(chartcode)
  choices <- NULL
  if (chartgrp == "nl2010") choices <- c("0-15 maanden" = "0-15m",
                                         "0-4 jaar" = "0-4y",
                                         "1-21 jaar" = "1-21y")
  if (chartgrp == "preterm") choices <- c("0-15 maanden" = "0-15m",
                                          "0-4 jaar" = "0-4y")
  if (chartgrp == "who") choices <- c("0-15 maanden" = "0-15m",
                                      "0-4 jaar" = "0-4y")
  agegrp <- switch(EXPR = parsed$design,
                   "A" = "0-15m",
                   "B" = "0-4y",
                   "C" = "1-21y",
                   "E" = "0-4y",
                   NULL)
  updateRadioButtons(session, "agegrp",
                     choices = choices, selected = agegrp)

  # update side radio button
  population <- tolower(parsed$population)
  design <- parsed$design
  choices <- NULL

  if (!is.null(agegrp) & !is.null(population) & length(chartgrp) > 0 ) {
    if (agegrp == "0-15m" & chartgrp == "nl2010")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Leeftijd" = "wgt",
                   "Hoofdomtrek" = "hdc",
                   "-A-" = "front",
                   "-B-" = "back")
    if (agegrp == "0-15m" & chartgrp == "preterm")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Leeftijd" = "wgt",
                   "Hoofdomtrek" = "hdc",
                   "-A-" = "front")
    if (agegrp == "0-15m" & chartgrp == "who")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Leeftijd" = "wgt",
                   "Hoofdomtrek" = "hdc",
                   "-A-" = "front")

    # browser()
    if (agegrp == "0-4y" & chartgrp == "nl2010" & population == "nl")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Lengte" = "wfh",
                   "Gewicht - Leeftijd" = "wgt",
                   "Hoofdomtrek" = "hdc",
                   "-A-" = "front",
                   "-B-" = "back")
    if (agegrp == "0-4y" & chartgrp == "nl2010" & population != "nl")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Lengte" = "wfh",
                   "Hoofdomtrek" = "hdc",
                   "-A-" = "front",
                   "-B-" = "back")
    if (agegrp == "0-4y" & chartgrp == "nl2010" & population == "hs")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Lengte" = "wfh",
                   "-A-" = "front",
                   "-B-" = "-hdc")
    if (agegrp == "0-4y" & chartgrp == "preterm")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Leeftijd" = "wgt",
                   "-A-" = "front")
    if (agegrp == "0-4y" & chartgrp == "who")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Lengte" = "wfh",
                   "-A-" = "front")

    if (agegrp == "1-21y" & population != "hs")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Lengte" = "wfh",
                   "Hoofdomtrek" = "hdc",
                   "BMI" = "bmi",
                   "-A-" = "front",
                   "-B-" = "back")
    if (agegrp == "1-21y" & population == "hs")
      choices <- c("Lengte" = "hgt",
                   "Gewicht - Lengte" = "wfh",
                   "BMI" = "bmi",
                   "-A-" = "front")
    side <- parsed$side
    updateRadioButtons(session, "side",
                       choices = choices, selected = side)
  }

  # update etnicity
  if (chartgrp == 'nl2010')
    updateRadioButtons(session, "etnicity", selected = parsed$population)

  # update preterm week
  if (chartgrp == 'preterm')
    updateSliderInput(session, "week", value = parsed$week)

  # update sex
  sex <- ifelse(parsed$sex == "female", "f", "m")
  updateRadioButtons(session, "sex", selected = sex)

}
