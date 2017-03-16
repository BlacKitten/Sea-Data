library(shiny)
library(shinythemes)
library(plotly)
shinyUI(fluidPage(theme = shinytheme("cerulean"),
  shinyUI(navbarPage("Sea Data",
     tabPanel("View Systems",
        navlistPanel(
          "Choose Viewpoint", 
          tabPanel("Variables",
                   verbatimTextOutput("variables")),
          tabPanel("Frequency of System by Model",
                   verbatimTextOutput("model")),
          tabPanel("Frequency of System by Company",
                   verbatimTextOutput("company")),
          tabPanel("Summary of Systems",
                   tags$h1("Type in a System ID:"), textInput("choice", "Select System:"),
                   tags$h2("Write Variables"), verbatimTextOutput("writeSummary"),
                   tags$h2("Read Variables"), verbatimTextOutput("readSummary"),
                   tags$h2("Total Variables"), verbatimTextOutput("totalSummary"),
                   tags$h2("Bandwidth Variables"), verbatimTextOutput("bandwidthSummary"),
                   tags$h2("IO Variables"), verbatimTextOutput("ioSummary"))
        )),
     tabPanel("Visualization 1",
        navlistPanel(
          "Visualization Panel",
          tabPanel("readsGt32msPct vs writesGt32msPct",
                   tags$h1("Type in a System ID:"), textInput("input32", "Select System:"), textInput("input32_", "Select System:"),
                   tags$h3("Choice 1"), plotlyOutput("plot32"),
                   tags$h3("Choice 2"), plotlyOutput("plot32_")),
          tabPanel("Custom Plotting",
                   tags$h1("Type in a System ID:"), textInput("in1", "Select System:"), textInput("in2", "Select System:"),
                   tags$h1("Choose Variable for X-axis:"), selectInput("x", "X-Variable:", 
                           choices=c("readsGt32msPct", "writesGt32msPct", "readsGt64msPct", "writesGt64msPct")),
                   tags$h1("Choose Variable for Y-axis:"), selectInput("y", "Y-Variable:", 
                           choices=c("readsGt32msPct", "writesGt32msPct", "readsGt64msPct", "writesGt64msPct")),
                   tags$h3("Choice 1"), plotlyOutput("customPlot1"),
                   tags$h3("Choice 2"), plotlyOutput("customPlot2"))
        )),
     tabPanel("Visualization 2"),
     navbarMenu("More",
        tabPanel("Visualization 3"),
        tabPanel("Visualization 4"))
  ))
))
