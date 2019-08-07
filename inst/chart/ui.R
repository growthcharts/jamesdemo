library("jamestest")
library("jamesclient")
library("shinydashboard")
library("shiny")

header <- shinydashboard::dashboardHeader(
  title = "JAMES test")

sidebar <- shinydashboard::dashboardSidebar(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  selectInput(inputId = "cabinet",
              label = "Groep",
              choices = c("-" = "none",
                          "SMOCK" = "smocc",
                          "Pinkeltje" = "preterm",
                          "Graham" = "graham",
                          "Terneuzen" = "terneuzen"),
              selected =  "none"),
  conditionalPanel(
    condition = "input.cabinet == 'none'",
    selectInput(inputId = "cpn.none",
                label = "Naam kind",
                choices = c("-" = "1"),
                selected = "1")
  ),
  conditionalPanel(
    condition = "input.cabinet == 'smocc'",
    selectInput(inputId = "cpn_smocc",
                label = "Naam kind",
                choices = c("Laura S" = "Laura_S",
                            "Thomas S" = "Thomas_S",
                            "Anne S" = "Anne_S",
                            "Jeroen S" = "Jeroen_S",
                            "Mark S" = "Mark_S",
                            "Kevin S" = "Kevin_S",
                            "Linda S" = "Linda_S",
                            "Iris S" = "Iris_S",
                            "Tim S" = "Tim_S",
                            "Rick S" = "Rick_S"),
                selected = "Laura_S")
  ),
  conditionalPanel(
    condition = "input.cabinet == 'preterm'",
    selectInput(inputId = "cpn.preterm",
                label = "Naam kind",
                choices = c("Jurre P" = "Jurre_P",
                            "Sanne P" = "Sanne_P",
                            "Milan P" = "Milan_P",
                            "Roos P" = "Roos_P",
                            "Bram P" = "Bram_P",
                            "Freek P" = "Freek_P",
                            "Anouk P" = "Anouk_P",
                            "Sharon P" = "Sharon_P",
                            "Nick P" = "Nick_P",
                            "Simon P" = "Simon_P"),
                selected = "Jurre_P")
  ),
  conditionalPanel(
    condition = "input.cabinet == 'graham'",
    selectInput(inputId = "cpn.graham",
                label = "Naam kind",
                choices = c("Lotte G" = "Lotte_G",
                            "Tim G" = "Tim_G",
                            "Hasna G" = "Hasna_G",
                            "Naomi G" = "Naomi_G",
                            "Sven G" = "Sven_G",
                            "Nikki G" = "Nikki_G",
                            "Nienke G" = "Nienke_G",
                            "Femke G" = "Femke_G",
                            "Bas G" = "Bas_G"),
                selected = "Lotto_G")
  ),
  conditionalPanel(
    condition = "input.cabinet == 'terneuzen'",
    selectInput(inputId = "cpn.terneuzen",
                label = "Naam kind",
                choices = c("T 163" = "T_163",
                            "T 1017" = "T_1017",
                            "T 1413" = "T_1413",
                            "T 2035" = "T_2035",
                            "T 2602" = "T_2602",
                            "T 3254" = "T_3254",
                            "T 4207" = "T_4207",
                            "T 5002" = "T_5002",
                            "T 5270" = "T_5270",
                            "T 6021" = "T_6021"),
                selected = "T_163")
  ),
  selectInput(inputId = "server",
              label = "JAMES server",
              choices = c("groeidiagrammen.nl" = "groeidiagrammen.nl",
                          "localhost" = "localhost"),
              selected = "groeidiagrammen.nl")
)


body <- shinydashboard::dashboardBody(htmlOutput("james"))

shinydashboard::dashboardPage(header, sidebar, body)

