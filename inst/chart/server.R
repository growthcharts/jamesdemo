shinyServer(function(input, output, session) {

  # --- begin reactive functions ---
  current.childname <- reactive({
    cab <- input$cabinet
    childname <- switch(cab,
                        "none" = "1",
                        "smocc" = input$cpn_smocc,
                        "preterm" = input$cpn.preterm,
                        "graham" = input$cpn.graham,
                        "terneuzen" = input$cpn.terneuzen,
                        "test" = input$cpn.test,
                        "0")
    return(childname)
  })

  current.cabinet <- reactive({
    input$cabinet
  })

  current.format <- reactive({
    input$format
  })

  current.target <- reactive({
    childname <- current.childname()
    if (childname == "0") return(NULL)
    if (childname == "1") return(NULL)
    cc <- current.cabinet()
    if (cc == "preterm") cc <- "lollypop"
    cf <- current.format()
    fn <- system.file("extdata", paste0("bds_v", cf), cc, paste0(childname, ".json"),
                      package = "jamesdemodata")
    target <- readLines(con = fn)
    return(target)
  })

  current.host <- reactive({
    switch(input$server,
           james.groeidiagrammen.nl = "https://james.groeidiagrammen.nl",
           test.groeidiagrammen.nl = "https://test.groeidiagrammen.nl",
           localhost = "http://localhost",
           "")
  })

  current.url <- reactive({
    bds  <- current.target()
    host <- current.host()
    r <- jamesclient::james_post(host = host,
                                 path = "/site/request/json",
                                 txt = bds)
    r$parsed
  })
  # --- end reactive functions

  output$james <- renderUI({
    site_url <- current.url()
    tags$iframe(src = site_url, width = "100%", height = "1311px", style = "border:1px dotted #18BC9C;")
  })
}
)


