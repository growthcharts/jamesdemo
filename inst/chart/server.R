shinyServer(function(input, output, session) {

  # embedding adapted from https://stackoverflow.com/questions/33020558/embed-iframe-inside-shiny-app

  # initialize local (user) variables
  cabinets <- list2env(installed.cabinets)
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

  current.url <- reactive({
    individual <- current.target()
    bds <- minihealth::convert_individual_bds(ind = individual)
    # browser()
    # save as file - hack
    #fn <- "upload.json"
    #con <- file(fn, "wt")
    #writeLines(text = bds, con = con)
    #
    jamesclient::request_site(txt = bds)
    #close(con)
  })
  # --- end reactive functions

  # --- begin observers
  # if the target changes, update the site-url
  # --- end observers

  output$james <- renderUI({
    site_url <- current.url()
    my_test <- tags$iframe(src = site_url, width = "100%", height = "1311px", style="border:2px dotted gray;")
    print(my_test)
    my_test
  })
}
)


