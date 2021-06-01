library("jamestest")
library("jamesdemodata")
library("jamesclient")
library("httr")

header <- shinydashboard::dashboardHeader(
  title = "JAMES tryout")

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
                          "Terneuzen" = "terneuzen",
                          "Test" = "test"),
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
  conditionalPanel(
    condition = "input.cabinet == 'test'",
    selectInput(inputId = "cpn.test",
                label = "Naam test",
                choices = c("T1 normal file" = "test1",
                            "T2 No Referentie" = "test2",
                            "T3 No OrganisatieCode" = "test3",
                            "T4 OrganisatieCode is string" = "test4",
                            "T5 No ClientGegevens" = "test5",
                            "T6 No ContactMomenten" = "test6",
                            "T7 No Referentie & OrganisatieCode" = "test7",
                            "T8 Invalid OrganisatieCode" = "test8",
                            "T9 No bds 19" = "test9",
                            "T10 No bds 20" = "test10",
                            "T11 No bds 82" = "test11",
                            "T12 No bds 91" = "test12",
                            "T13 No bds 110" = "test13",
                            "T14 Empty file" = "test14",
                            "T15 Numeric bds 19 + 62" = "test15",
                            "T16 Numeric bds 20" = "test16",
                            "T17 Numeric bds 82" = "test17",
                            "T18 Numeric bds 91" = "test18",
                            "T19 Numeric bds 110" = "test19",
                            "T20 No Groepen" = "test20",
                            "T21 Minimal JSON" = "test21",
                            "T22 Range checks" = "test22",
                            "T23 Num 19 + 62, range 82 + 252, no groepen" = "test23",
                            "T24 Add ddi" = "test24",
                            "T25 Extreme D-score at start" = "test25",
                            "B1 no_vector bug" = "not_a_vector",
                            "B2 http400 bug" = "http400"),
                selected = "test1")
  ),
  selectInput(inputId = "server",
              label = "Server",
              choices = c("James" = "groeidiagrammen.nl",
                          "June" = "vps.stefvanbuuren.nl",
                          "Joshua" = "localhost"),
              selected = "groeidiagrammen.nl")
)


body <- shinydashboard::dashboardBody(htmlOutput("james"))

shinydashboard::dashboardPage(header, sidebar, body)

