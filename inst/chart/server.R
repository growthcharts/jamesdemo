shinyServer(function(input, output, session) {

  # initialize user cabinets and chartlist
  cabinets <- list2env(installed.cabinets)

  # update the main chart, and wait for user
  output$mainplot <- renderPlot({chartit()}, res = 144)

  output$plot_as_svg <- renderImage({

    # Read myImage's width and height in px. These are reactive values,
    # so this expression will re-run whenever they change.
    width  <- session$clientData$output_plot_as_svg_width
    height <- session$clientData$output_plot_as_svg_height
    pixelratio <- session$clientData$pixelratio

    # calculate width for A4 and square chart types
    width_user_cm <- 18
    chartcode <- isolate(state$chartcode)
    side <- substr(chartcode, 4L, 4L)
    square <- ifelse(side %in% c("A", "B", "C"), FALSE, TRUE)
    width_cm <-  ifelse(square, width_user_cm, width_user_cm)
    height_cm <- ifelse(square, width_user_cm, width_user_cm / 18 * 29.7)

    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext = '.svg')

    # Generate the svg
    svg(outfile, width = width_cm / 2.54, height = height_cm / 2.54)
    chartit()
    dev.off()

    # Return a list containing the filename
    list(src = normalizePath(outfile),
         contentType = 'image/svg+xml',
         width = height,
         height = height,
         alt = paste("Growth chart", chartcode))
  })

  output$chartcode <- renderText({state$chartcode})

  state <- reactiveValues(refresh = 1, chartgrp = "nl2010",
                          chartcode = "NJAH", datapriority = FALSE)

  # --- begin reactive functions ---
  current.childnum <- reactive({
    cab <- input$cabinet
    childnum <- switch(cab,
                       "none" = 1,
                       "smocc" = as.numeric(input$cpn_smocc),
                       "preterm" = as.numeric(input$cpn.preterm),
                       "mykids" = as.numeric(input$cpn.mykids),
                       "graham" = as.numeric(input$cpn.graham),
                       "terneuzen" = as.numeric(input$cpn.terneuzen),
                       0)
    return(childnum)
  })

  current.cabinet <- reactive({
    get(input$cabinet, envir = cabinets, inherits = FALSE)
  })

  current.target <- reactive({
    childnum <- current.childnum()
    if (childnum == 0) return(NULL)
    target <- current.cabinet()[[childnum]]
    return(target)
  })

  # current.chartgrp <- reactive({
  #   input$chartgrp
  # })

  current.chartcode <- reactive({
    state$chartcode
  })
  # --- end reactive functions ---

  # --- begin observers
  observeEvent(
    input$kkk,
    {
      if (input$kkk == "chart") {
        chartgrp <- input$chartgrp
        chartcode <- current.chartcode()
        update_chart_controls(session, chartgrp, chartcode)
      }
    }
  )

  # if the target changes, update chartgrp and chartcode
  # according to user values, and trigger redraw
  observeEvent(
    current.target(),
    {
      chart <- select_chart(ind = current.target())
      chartgrp <- chart$chartgrp
      chartcode <- chart$chartcode
      updateSelectInput(session, "chartgrp",
                        selected = chartgrp)

      update_chart_controls(session, chartgrp, chartcode,
                            ga = chart$ga)

      state$chartgrp <- chartgrp
      state$chartcode <- chartcode
      state$refresh <- state$refresh + 1L
      state$datapriority <- TRUE
    }
  )

  # if user choses a chart option
  observeEvent(
    {input$chartgrp; input$agegrp; input$side; input$etnicity; input$week; input$sex},
    {
      if (state$datapriority) {
        # signal that we do not want to redraw if the chart is chosen
        # according to the individual's data
        state$datapriority <- FALSE
      } else {
        chart <- select_chart(ind = NULL,
                              chartgrp = input$chartgrp,
                              agegrp = input$agegrp,
                              side = input$side,
                              ga = input$week,
                              etn = input$etnicity,
                              sex = input$sex)
        chartgrp <- chart$chartgrp
        chartcode <- chart$chartcode
        update_chart_controls(session, chartgrp, chartcode)

        state$chartcode <- chartcode
        state$refresh <- state$refresh + 1L
      }
    }
  )
  # --- end observers

  # chartit: redraw if chartcode changes (which may be the result
  # of a change in current.target()), or if user pressed drawit
  chartit <- function() {
    i <- state$refresh
    ind <- isolate(current.target())
    chartcode <- isolate(state$chartcode)
    draw_plot(ind = ind, chartcode = chartcode,
              curve_interpolation = input$interpolation)
  }

  create_pdf <- function() {
    temp <- tempfile(fileext = ".pdf")
    pdf(file = temp, height = 29.7/2.54, width = 21/2.54)
    ind <- isolate(current.target())
    chartcode <- isolate(state$chartcode)
    draw_plot(ind = ind, chartcode = chartcode,
              curve_interpolation = input$interpolation)
    dev.off()
    return(temp)
  }

  output$downloadpdf <- downloadHandler(
    filename = function()
      paste0(paste(Sys.Date(),
                   current.chartcode(),
                   current.cabinet()[[current.childnum()]]@name,
                   sep = "_"), ".pdf"),
    content = function(file) {
      file.copy(create_pdf(), file)
    }
  )

  # create.png <- reactive({
  #   temp <- tempfile(fileext=".png")
  #
  #   png(file = temp, height = input$height, width = input$width, res = 144)
  #   draw.plot()
  #   dev.off()
  #   return(temp)
  # })
  #
  #   output$downloadPdf <- downloadHandler(
  #     filename =  file.path(getwd(),paste("output","pdf",sep=".")),
  #     content = function(filepath) {
  #       pdffile <- create.pdf()
  #       on.exit(unlink(pdffile))
  #       bytes <- readBin(pdffile, "raw", file.info(pdffile)$size)
  #       writeBin(bytes, filepath)
  #     }
  #   )
  #
  #   output$downloadPng <- downloadHandler(
  #     filename =  file.path(getwd(),paste("output","png",sep=".")),
  #     content <- function(file) {
  #       png(file, width =  input$width, height = input$height, units = "px", pointsize = 12,
  #           bg = "white", res = 144)
  #       draw.plot()
  #       dev.off()},
  #     contentType = 'image/png'
  #   )
}
)

