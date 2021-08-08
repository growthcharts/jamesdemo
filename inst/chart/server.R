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

  current.target <- reactive({
    childname <- current.childname()
    if (childname == "0") return(NULL)
    if (childname == "1") return(NULL)
    cc <- current.cabinet()
    if (cc == "preterm") cc <- "lollypop"
    fn <- system.file("extdata", paste0("bds_", input$schema), cc, paste0(childname, ".json"),
                      package = "jamesdemodata")
    # target <- jsonlite::minify(readLines(con = fn))
    target <- readLines(con = fn)
    # url <- paste0("https://raw.githubusercontent.com/growthcharts/jamesdemo/master/inst/extdata/test/", childname, ".json")
    # target <- readLines(con = url)
    # target url does not yet work
    # target <- url
    return(target)
  })

  current.host <- reactive({
    switch(input$server,
           groeidiagrammen.nl = "https://groeidiagrammen.nl",
           james.tno.nl = "https://james.tno.nl",
           vps.stefvanbuuren.nl = "https://vps.stefvanbuuren.nl",
           localhost = "http://localhost")
  })
  current.path <- reactive({
    switch(input$server,
           groeidiagrammen.nl = "ocpu/library/james",
           james.tno.nl = "ocpu/library/james",
           vps.stefvanbuuren.nl = "ocpu/library/james",
           localhost = "ocpu/library/james")
  })

  current.url <- reactive({
    bds  <- current.target()
    host <- current.host()
    path <- current.path()
    app  <- file.path(host, path, "www/")
    fun  <- file.path(host, path, "R/fetch_loc")

    # bds is a URL or a JSON string
    if (is.null(bds)) return(app)
    resp <- POST(url = fun,
                       body = list(txt = bds),
                       encode = "json",
                       add_headers(Accept = "plain/text"))

    # throw warnings and messages
    url_warnings <- jamesclient::get_url(resp, "warnings")
    url_messages <- jamesclient::get_url(resp, "messages")
    if (length(url_warnings) >= 1L)
      warning(content(GET(url_warnings), "text", encoding = "utf-8"))
    if (length(url_messages) >= 1L)
      message(content(GET(url_messages), "text", encoding = "utf-8"))

    # stop for unsuccesful request
    stop_for_status(resp,
                    task = paste0("upload data", "\n  ",
                                   content(resp, "text", encoding = "utf-8")))

    if (http_error(resp)) app
    else paste(app, paste("ind", headers(resp)$location, sep = "="), sep = "?")
  })
  # --- end reactive functions

  output$james <- renderUI({
    site_url <- current.url()
    tags$iframe(src = site_url, width = "100%", height = "1311px", style="border:1px dotted #18BC9C;")
  })
}
)


