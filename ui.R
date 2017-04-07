library(shiny)
library(shinythemes)
library(plotly)

# Define a User Interface using the Shiny Package
shinyUI(fluidPage(
  tags$head(tags$link(rel = "shortcut icon", href = "URL-to-favicon")),
  #Uses the shinytheme package to make the website cerulean
  theme = shinytheme("cerulean"),
  shinyUI(
    # A navbarPage is a template for tabs.
    navbarPage(
      "Sea Data",
      # The tabPanel is a tab.
      tabPanel(
        # This is the name of the tab.
        "View Systems",
        # This is a panel to define more tabs.
        navlistPanel(
          # This is a title.
          "Choose Viewpoint",
          # Define a tab called "Variables"
          tabPanel("Variables", 
                   #Call the function "variables" located in the server.R file
                   verbatimTextOutput("variables")),
          # Define a tab called "Frequency of System by Model"
          tabPanel("Frequency of System by Model", 
                   #Call the function "model" located in the server.R file
                   plotlyOutput("model")),
          # Define a tab called ""Frequency of System by Company"
          tabPanel("Frequency of System by Company", 
                   #Call the function "company" located in the server.R file
                   verbatimTextOutput("company")),
          tabPanel(
            # Define a tab called "Summary of Systems"
            "Summary of Systems",
            #HTML tag; h1 means Header 1.
            tags$h1("Type in a System ID:"),
            #Textbox for the user to type in.
            textInput("choice", "Select System:"),
            #HTML tag; H2 means Header 2.
            tags$h2("Write Variables"),
            #Calling the "writeSummary" function.
            verbatimTextOutput("writeSummary"),
            tags$h2("Read Variables"),
            verbatimTextOutput("readSummary"),
            tags$h2("Total Variables"),
            verbatimTextOutput("totalSummary"),
            tags$h2("Bandwidth Variables"),
            verbatimTextOutput("bandwidthSummary"),
            tags$h2("IO Variables"),
            verbatimTextOutput("ioSummary")
          )
        )
      ),
      tabPanel(
        "Scatter Plot",
        navlistPanel(
          "Visualization Panel",
          tabPanel(
            "Scatter Plot",
            tags$h1("Type in a System ID:"),
            splitLayout(
              cellWidths = c("50%", "50%"),
              textInput("in1", "Select System:"),
              textInput("in2", "Select System:")
            ),
            tags$h1("Choose a Plot"),
            #Define a dropdown; the input ID is "x" which will be referenced in the server.R file
            selectInput(
              "x",
              "Plots:",
              choices = c(
                "readsGt32msPct vs writesGt32msPct",
                "readsGt64msPct vs writesGt64msPct",
                "readsGt128msPct vs writesGt128msPct",
                "readsGt256msPct vs writesGt256msPct",
                "readsGt512msPct vs writesGt512msPct",
                "readsGt1024msPct vs writesGt1024msPct",
                "readsGt2048msPct vs writesGt2048msPct",
                "readsGt4096msPct vs writesGt4096msPct",
                "reads0_062msPct vs writes0_062msPct",
                "reads0_125msPct vs writes0_125msPct",
                "reads0_25msPct vs writes0_25msPct",
                "reads0_5msPct vs writes0_5msPct",
                "reads1msPct vs writes1msPct",
                "reads2msPct vs writes2msPct",
                "reads4msPct vs writes4msPct",
                "reads8msPct vs writes8msPct",
                "reads16msPct vs writes16msPct",
                "reads32msPct vs writes32msPct",
                "reads64msPct vs writes64msPct",
                "reads128msPct vs writes128msPct",
                "reads256msPct vs writes256msPct",
                "reads515msPct vs writes515msPct",
                "reads1024msPct vs writes1024msPct",
                "reads2048msPct vs writes2048msPct",
                "reads4096msPct vs writes4096msPct",
                "reads8192msPct vs writes8192msPct",
                "reads16384msPct vs writes16384msPct",
                "reads32768msPct vs writes32768msPct",
                "reads65536msPct vs writes65536msPct"
                ),
              width = '350px'
            ),
            tags$h3("Choice 1"),
            #Plot the function "customPlot1" from the server.R file
            plotlyOutput("customPlot1"),
            tags$h3("Choice 2"),
            #Plot the function "customPlot2" from the server.R file
            plotlyOutput("customPlot2")
          )
        )
      )
    )
  )
))
