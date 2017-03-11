library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons("dist", "Distribution type:",
                   c("Normal" = "norm",
                     "Uniform" = "unif",
                     "Log-normal" = "lnorm",
                     "Exponential" = "exp")),
      br(),
      
      sliderInput("n", 
                  "Number of observations:", 
                  value = 500,
                  min = 1, 
                  max = 1000)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       tabsetPanel(type = "tabs", 
                   tabPanel("Plot", plotOutput("plot")), 
                   tabPanel("Summary", verbatimTextOutput("summary")), 
                   tabPanel("Table", tableOutput("table"))
       )
    )
  )
))
