header <- shinydashboard::dashboardHeader(title = "Groeidiagrammen")

sidebar <- shinydashboard::dashboardSidebar(
  tags$head(tags$script(src = "message-handler.js"),
            tags$style(HTML("#saveEditsButton {
                            background-color: orange;
                            }"))),

  radioButtons(inputId = "kkk",
               label = "Kies",
               choices = c("Kind" = "child",
                           "Kaart" = "chart"),
               selected = "child",
               inline = TRUE),
  conditionalPanel(
    condition = "input.kkk == 'child'",
    wellPanel(
      selectInput(inputId = "cabinet",
                  label = "Groep",
                  choices = c("-" = "none",
                              "SMOCK" = "smocc",
                              "Pinkeltje" = "preterm",
                              "Graham" = "graham",
                              "Terneuzen" = "terneuzen",
                              "Mijn kinderen" = "mykids"),
                  selected =  "none"
      ),
      conditionalPanel(
        condition = "input.cabinet == 'none'",
        selectInput(inputId = "cpn.none",
                    label = "Naam kind",
                    choices = c("-" = "1"),
                    selected = "1"
        )
      ),
      conditionalPanel(
        condition = "input.cabinet == 'smocc'",
        selectInput(inputId = "cpn_smocc",
                    label = "Naam kind",
                    choices = c("Laura S" = "1",
                                "Thomas S" = "2",
                                "Anne S" = "3",
                                "Jeroen S" = "4",
                                "Mark S" = "5",
                                "Kevin S" = "6",
                                "Linda S" = "7",
                                "Iris S" = "8",
                                "Tim S" = "9",
                                "Rick S" = "10"),
                    selected = "1"
        )
      ),
      conditionalPanel(
        condition = "input.cabinet == 'preterm'",
        selectInput(inputId = "cpn.preterm",
                    label = "Naam kind",
                    choices = c("Jurre P" = "1",
                                "Sanne P" = "2",
                                "Milan P" = "3",
                                "Roos P" = "4",
                                "Bram P" = "5",
                                "Freek P" = "6",
                                "Anouk P" = "7",
                                "Sharon P" = "8",
                                "Nick P" = "9",
                                "Simon P" = "10"),
                    selected = "1"
        )
      ),
      conditionalPanel(
        condition = "input.cabinet == 'graham'",
        selectInput(inputId = "cpn.graham",
                    label = "Naam kind",
                    choices = c("Lotte G" = "1",
                                "Tim G" = "2",
                                "Hasna G" = "3",
                                "Naomi G" = "4",
                                "Sven G" = "5",
                                "Nikke G" = "6",
                                "Nienke G" = "7",
                                "Femke G" = "8",
                                "Bas G" = "9"),
                    selected = "1")
      ),
      conditionalPanel(
        condition = "input.cabinet == 'terneuzen'",
        selectInput(inputId = "cpn.terneuzen",
                    label = "Naam kind",
                    choices = c("T 163" = "1",
                                "T 1017" = "2",
                                "T 1413" = "3",
                                "T 2035" = "4",
                                "T 2602" = "5",
                                "T 3254" = "6",
                                "T 4207" = "7",
                                "T 5002" = "8",
                                "T 5270" = "9",
                                "T 6021" = "10"),
                    selected = "1"
        )
      ),
      conditionalPanel(
        condition = "input.cabinet == 'mykids'",
        selectInput(inputId = "cpn.mykids",
                    label = "Naam kind",
                    choices = c("Kind 1" = "1",
                                "Kind 2" = "2",
                                "Kind 3" = "3",
                                "Kind 4" = "4",
                                "Kind 5" = "5",
                                "Kind 6" = "6",
                                "Kind 7" = "7",
                                "Kind 8" = "8",
                                "Kind 9" = "9",
                                "Kind 10" = "10"),
                    selected = "1"
        )
      )
    )
  ),
  conditionalPanel(
    condition = "input.kkk == 'chart'",

    selectInput(inputId = "chartgrp",
                label = "Kaartserie",
                choices = c("Nederland 2010" = "nl2010",
                            "Prematuren" = "preterm",
                            "WHO standaard" = "who"),
                selected = "nl2010"),

    div(style = "width:200px;margin:0 auto;",
        verbatimTextOutput("chartcode", placeholder = TRUE)),

    radioButtons(inputId = "agegrp",
                 label = "Leeftijd",
                 choices = c("0-15 maanden" = "0-15m",
                             "0-4 jaar" = "0-4y",
                             "1-21 jaar" = "1-21y"),
                 selected = "0-15m"),

    radioButtons(inputId = "side",
                 label = "Kaartsoort",
                 choices = c("Lengte" = "hgt",
                             "Gewicht - Leeftijd" = "wgt",
                             "Gewicht - Lengte" = "wfh",
                             "Hoofdomtrek" = "hdc",
                             "BMI" = "bmi",
                             "Voor" = "front",
                             "Achter" = "back"),
                 selected = "hgt"),

    conditionalPanel(
      condition = "input.chartgrp == 'nl2010'",
      radioButtons(inputId = "etnicity",
                   label = "Etniciteit",
                   choices = c("Nederlands" = "nl",
                               "Turks" = "tu",
                               "Marokkaans" = "ma",
                               "Hindostaans" = "hs"),
                   selected = "nl"
      )
    ),

    conditionalPanel(
      condition = "input.chartgrp == 'preterm'",
      sliderInput(inputId = "week",
                  label = "Zwangerschapsduur (weken)",
                  min = 25, max = 36, value = 36, step = 1)
    ),

    radioButtons(inputId = "sex",
                 label = "Geslacht",
                 choices = c("Jongen" = "m",
                             "Meisje" = "f"),
                 selected = "m")

  ),

  checkboxInput("interpolation", "Curve interpolation", value = TRUE),

  # wellPanel(sliderInput(inputId = "height",
  #             label = "Hoogte (cm)",
  #             min = 5, max = 20, value = 16, step = 1),

  # sliderInput(inputId = "width",
  #             label = "Breedte (cm)",
  #             min = 12, max = 24, value = 18, step = 1),

  div(style = "width:200px;margin:0 auto;",
      downloadButton('downloadpdf', 'Download PDF'))
)


# body <- shinydashboard::dashboardBody(
#   tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
#   plotOutput("mainplot", width = "1060px", height = "1680px")
# )

body <- shinydashboard::dashboardBody(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
  imageOutput("plot_as_svg", height = "700px")
  # imageOutput("plot_as_svg", width = "780px", height = "1103px")
  # imageOutput("plot_as_svg", width = "780px", height = "780px")
  # imageOutput("plot_as_svg", inline = TRUE)
)

shinydashboard::dashboardPage(header, sidebar, body)

