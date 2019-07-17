shinyServer(function(input, output, session) {

  # embedding adapted from https://stackoverflow.com/questions/33020558/embed-iframe-inside-shiny-app
  
  # initialize user cabinets and chartlist
  cabinets <- list2env(installed.cabinets)
  
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
  # --- end reactive functions
  
  # --- begin observers
  # if the target changes, update the site-url
  observeEvent(
    current.target(),
    {
      individual <- current.target()
      # convert to BDS
      # convert to JSON
      # POST REQUEST
      # GET site-url
      # store site_url as global
      site_url <<- "http://groeidiagrammen.nl/ocpu/lib/james/www/"
    }
  )
  # --- end observers
  
  output$james <- renderUI({
    individual <- current.target()
    my_test <- tags$iframe(src = site_url, width = "100%", height = "1311px", style="border:2px dotted gray;")
    print(my_test)
    my_test
  })
}
)


