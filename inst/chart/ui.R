header <- shinydashboard::dashboardHeader(title = "JAMES tester")

sidebar <- shinydashboard::dashboardSidebar(
  wellPanel(
    selectInput(inputId = "cabinet",
                label = "Groep",
                choices = c("-" = "none",
                            "SMOCK" = "smocc",
                            "Pinkeltje" = "preterm",
                            "Graham" = "graham",
                            "Terneuzen" = "terneuzen",
                            "Mijn kinderen" = "mykids"),
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
                  selected = "1")
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
                  selected = "1")
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
                  selected = "1")
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
                  selected = "1")
    )
  )
)

body <- shinydashboard::dashboardBody(htmlOutput("james"))

shinydashboard::dashboardPage(header, sidebar, body)

