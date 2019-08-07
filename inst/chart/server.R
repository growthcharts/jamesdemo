shinyServer(function(input, output, session) {

  # embedding adapted from https://stackoverflow.com/questions/33020558/embed-iframe-inside-shiny-app

  # initialize local (user) variables
  # cabinets <- list2env(jamestest::installed.cabinets)
  # site_url <- "http://groeidiagrammen.nl/ocpu/lib/james/www/"

  # --- begin reactive functions ---
  current.childname <- reactive({
    cab <- input$cabinet
    childname <- switch(cab,
                       "none" = "1",
                       "smocc" = input$cpn_smocc,
                       "preterm" = input$cpn.preterm,
                       "graham" = input$cpn.graham,
                       "terneuzen" = input$cpn.terneuzen,
                       "0")
    return(childname)
  })

  current.cabinet <- reactive({
    input$cabinet
  })

  current.target <- reactive({
    childnum <- current.childname()
    if (childname == "0") return(NULL)
    if (childname == "1") return(NULL)
    fn <- file.path(path.package("jamestest"), "extdata",
                    current.cabinet(), paste0(childname, ".json"))
    target <- readLines(con = fn)
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
    bds <- current.target()
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


