shinyServer(function(input, output, session) {

  # embedding adapted from https://stackoverflow.com/questions/33020558/embed-iframe-inside-shiny-app

  # initialize local (user) variables
  cabinets <- list2env(jamestest::installed.cabinets)
  # site_url <- "http://groeidiagrammen.nl/ocpu/lib/james/www/"

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

  current.host <- reactive({
    switch(input$server,
           groeidiagrammen.nl = "https://groeidiagrammen.nl",
           james.tno.nl = "https://james.tno.nl",
           localhost = "http://localhost:5656")
  })
  current.path <- reactive({
    switch(input$server,
           groeidiagrammen.nl = "ocpu/library/james",
           james.tno.nl = "ocpu/library/james",
           localhost = "ocpu/apps/stefvanbuuren/james")
  })

  current.url <- reactive({
    individual <- current.target()
    bds <- minihealth::convert_individual_bds(ind = individual)
    jamesclient::request_site(bds,
                              host = current.host(),
                              path = current.path())
  })
  # --- end reactive functions

  output$james <- renderUI({
    site_url <- current.url()
    tags$iframe(src = site_url, width = "100%", height = "1311px", style="border:1px dotted #18BC9C;")
  })
}
)


