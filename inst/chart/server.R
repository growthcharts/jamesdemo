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
    target <- jamesclient::read_json_js(txt = fn)
    return(target)
  })

  current.host <- reactive({
    switch(input$server,
           "james.groeidiagrammen.nl" = "https://james.groeidiagrammen.nl",
           "james-test.groeidiagrammen.nl" = "https://james.groeidiagrammen.nl",
           "localhost:8080" = "http://localhost:8080",
           "")
  })

  current.url <- reactive({
    bds <- current.target()
    host <- current.host()

    # We need different behavior for local and remote hosts
    # because local hosts do not support nested file uploads
    if (host %in% c("http://localhost:8080", "http://127.0.0.1:8080")) {
      # Step 1: Upload the data
      up <- jamesclient::james_post(
        host = host,
        sitehost = host,
        path = "data/upload",
        txt = bds,
        upload = FALSE
      )

      # Extract session key
      session <- up$session
      if (is.null(session) || session == "") {
        stop("Upload failed or session not returned.")
      }

      # Step 2: Run the main request with uploaded session
      r <- jamesclient::james_post(
        host = host,
        sitehost = host,
        path = "site/request/json",
        session = session,
        upload = FALSE
      )
    } else {
      # Regular call for remote hosts
      r <- jamesclient::james_post(
        host = host,
        sitehost = host,
        path = "site/request/json",
        txt = bds,
        upload = TRUE
      )
    }
    r$parsed
  })
  # --- end reactive functions

  output$james <- renderUI({
    site_url <- current.url()
    tags$iframe(src = site_url, width = "100%", height = "1311px", style = "border:1px dotted #18BC9C;")
  })
}
)


