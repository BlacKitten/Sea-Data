library(shiny)
library(plotly)

# Define a server using Shiny; pay close attention to the parameters (input, output). 
shinyServer(function(input, output) {
  #Define a variable that access all the CSV files in the working directory. The * is a regex expression.
  database <- Sys.glob("*-perform.csv")
  # Define a variable that imports the "perform-summary.csv" file. 
  sum <- read.csv("perform-summary.csv")
  
  #Define the "variables" function: reads in the first csv file and prints the first row (which are the column names)
  output$variables <- renderPrint({
    read.csv(database[1])[0, ]
  })
  
  # Define the "model" function: 
  output$model <- renderPlotly({
    # Define a variable takes the 3rd column (Model Types) of the sum variable.
    modelData <- as.data.frame(table(sum[, 3]))
    # Plot function
    ggplotly(
      plot_ly(
        data = modelData,
        #Set x axis to correspond to Model Type.
        x = modelData[, 1],
        #Set y axis to correspond to Frequency of each Model Type.
        y = modelData[, 2],
        #Set this plot to be a bargraph
        type = 'bar'
      ) %>% layout(
        title = "Frequency of Models",
        xaxis = list(title = "Model Type"),
        yaxis = list(title = "Frequency")
      )
    )
  })
  
  #Define a "company" function: prints the companies along with the servers they own. 
  output$company <- renderPrint({
    data <- as.data.frame(table(sum[, 2]))
    colnames(data) <- c("Company", "Freq.")
    data
  })
  
  output$writeSummary <- renderPrint({
    if (!is.na(as.numeric(input$choice)) &&
        as.numeric(input$choice) > 0 &&
        as.numeric(input$choice) <= length(database)) {
      summary(read.csv(database[as.numeric(input$choice)])[, c(12:41)])
    }
    else
      "System ID does not exist."
  })
  output$readSummary <- renderPrint({
    if (!is.na(as.numeric(input$choice)) &&
        as.numeric(input$choice) > 0 &&
        as.numeric(input$choice) <= length(database)) {
      summary(read.csv(database[as.numeric(input$choice)])[, c(42:70)])
    }
    else
      "System ID does not exist."
  })
  output$totalSummary <- renderPrint({
    if (!is.na(as.numeric(input$choice)) &&
        as.numeric(input$choice) > 0 &&
        as.numeric(input$choice) <= length(database)) {
      summary(read.csv(database[as.numeric(input$choice)])[, c(71:99)])
    }
    else
      "System ID does not exist."
  })
  output$bandwidthSummary <- renderPrint({
    if (!is.na(as.numeric(input$choice)) &&
        as.numeric(input$choice) > 0 &&
        as.numeric(input$choice) <= length(database)) {
      summary(read.csv(database[as.numeric(input$choice)])[, c(100:102)])
    }
    else
      "System ID does not exist."
  })
  output$ioSummary <- renderPrint({
    if (!is.na(as.numeric(input$choice)) &&
        as.numeric(input$choice) > 0 &&
        as.numeric(input$choice) <= length(database)) {
      summary(read.csv(database[as.numeric(input$choice)])[, c(109:111)])
    }
    else
      "System ID does not exist."
  })
  
  output$customPlot1 <- renderPlotly({
    # Input cannot be gibberish and is within a valid range. 
    if (!is.na(as.numeric(input$in1)) &&
        as.numeric(input$in1) > 0 &&
        as.numeric(input$in1) <= length(database)) {
      #Maps each input for the dropdown to the columns of the data
      xVar <-
        switch(
          input$x,
          "readsGt32msPct vs writesGt32msPct" = 42,
          "readsGt64msPct vs writesGt64msPct" = 43,
          "readsGt128msPct vs writesGt128msPct" = 44,
          "readsGt256msPct vs writesGt256msPct" = 45,
          "readsGt512msPct vs writesGt512msPct" = 46,
          "readsGt1024msPct vs writesGt1024msPct" = 47,
          "readsGt2048msPct vs writesGt2048msPct" = 48,
          "readsGt4096msPct vs writesGt4096msPct" = 49,
          "reads0_062msPct vs writes0_062msPct" = 50,
          "reads0_125msPct vs writes0_125msPct" = 51,
          "reads0_25msPct vs writes0_25msPct" = 52,
          "reads0_5msPct vs writes0_5msPct" = 53,
          "reads1msPct vs writes1msPct" = 54,
          "reads2msPct vs writes2msPct" = 55,
          "reads4msPct vs writes4msPct" = 56,
          "reads8msPct vs writes8msPct" = 57,
          "reads16msPct vs writes16msPct" = 58,
          "reads32msPct vs writes32msPct" = 59,
          "reads64msPct vs writes64msPct" = 60,
          "reads128msPct vs writes128msPct" = 61,
          "reads256msPct vs writes256msPct" = 62,
          "reads515msPct vs writes515msPct" = 63,
          "reads1024msPct vs writes1024msPct" = 64,
          "reads2048msPct vs writes2048msPct" = 65,
          "reads4096msPct vs writes4096msPct" = 66,
          "reads8192msPct vs writes8192msPct" = 67,
          "reads16384msPct vs writes16384msPct" = 68,
          "reads32768msPct vs writes32768msPct" = 69,
          "reads65536msPct vs writes65536msPct" = 70
        )
      yVar <-
        switch(
          input$x,
          "readsGt32msPct vs writesGt32msPct" = 13,
          "readsGt64msPct vs writesGt64msPct" = 14,
          "readsGt128msPct vs writesGt128msPct" = 15,
          "readsGt256msPct vs writesGt256msPct" = 16,
          "readsGt512msPct vs writesGt512msPct" = 17,
          "readsGt1024msPct vs writesGt1024msPct" = 18,
          "readsGt2048msPct vs writesGt2048msPct" = 19,
          "readsGt4096msPct vs writesGt4096msPct" = 20,
          "reads0_062msPct vs writes0_062msPct" = 21,
          "reads0_125msPct vs writes0_125msPct" = 22,
          "reads0_25msPct vs writes0_25msPct" = 23,
          "reads0_5msPct vs writes0_5msPct" = 24,
          "reads1msPct vs writes1msPct" = 25,
          "reads2msPct vs writes2msPct" = 26,
          "reads4msPct vs writes4msPct" = 27,
          "reads8msPct vs writes8msPct" = 28,
          "reads16msPct vs writes16msPct" = 29,
          "reads32msPct vs writes32msPct" = 30,
          "reads64msPct vs writes64msPct" = 31,
          "reads128msPct vs writes128msPct" = 32,
          "reads256msPct vs writes256msPct" = 33,
          "reads515msPct vs writes515msPct" = 34,
          "reads1024msPct vs writes1024msPct" = 35,
          "reads2048msPct vs writes2048msPct" = 36,
          "reads4096msPct vs writes4096msPct" = 37,
          "reads8192msPct vs writes8192msPct" = 38,
          "reads16384msPct vs writes16384msPct" = 39,
          "reads32768msPct vs writes32768msPct" = 40,
          "reads65536msPct vs writes65536msPct" = 41
        )
      
      ggplotly(
        plot_ly(
          data = read.csv(database[as.numeric(input$in1)]),
          #set x-axis to be the input from the dropdown.
          x = read.csv(database[as.numeric(input$in1)])[, xVar],
          #set y-axis to be the input from the dropdown.
          y = read.csv(database[as.numeric(input$in1)])[, yVar],
          #Set graph to be a scatterplot.
          type = 'scatter',
          mode = 'markers'
        ) %>% layout(
          title = paste0("System ", input$in1),
          xaxis = list(title = sub(" .*", "", input$x)),
          yaxis = list(title = sub(".* ", "", input$x))
        )
      )
    }
    else{
      ggplotly(ggplot(NULL))
    }
  })
  
  output$customPlot2 <- renderPlotly({
    if (!is.na(as.numeric(input$in2)) &&
        as.numeric(input$in2) > 0 &&
        as.numeric(input$in2) <= length(database)) {
      xVar <-
        switch(
          input$x,
          "readsGt32msPct vs writesGt32msPct" = 42,
          "readsGt64msPct vs writesGt64msPct" = 43,
          "readsGt128msPct vs writesGt128msPct" = 44,
          "readsGt256msPct vs writesGt256msPct" = 45,
          "readsGt512msPct vs writesGt512msPct" = 46,
          "readsGt1024msPct vs writesGt1024msPct" = 47,
          "readsGt2048msPct vs writesGt2048msPct" = 48,
          "readsGt4096msPct vs writesGt4096msPct" = 49,
          "reads0_062msPct vs writes0_062msPct" = 50,
          "reads0_125msPct vs writes0_125msPct" = 51,
          "reads0_25msPct vs writes0_25msPct" = 52,
          "reads0_5msPct vs writes0_5msPct" = 53,
          "reads1msPct vs writes1msPct" = 54,
          "reads2msPct vs writes2msPct" = 55,
          "reads4msPct vs writes4msPct" = 56,
          "reads8msPct vs writes8msPct" = 57,
          "reads16msPct vs writes16msPct" = 58,
          "reads32msPct vs writes32msPct" = 59,
          "reads64msPct vs writes64msPct" = 60,
          "reads128msPct vs writes128msPct" = 61,
          "reads256msPct vs writes256msPct" = 62,
          "reads515msPct vs writes515msPct" = 63,
          "reads1024msPct vs writes1024msPct" = 64,
          "reads2048msPct vs writes2048msPct" = 65,
          "reads4096msPct vs writes4096msPct" = 66,
          "reads8192msPct vs writes8192msPct" = 67,
          "reads16384msPct vs writes16384msPct" = 68,
          "reads32768msPct vs writes32768msPct" = 69,
          "reads65536msPct vs writes65536msPct" = 70
        )
      yVar <-
        switch(
          input$x,
          "readsGt32msPct vs writesGt32msPct" = 13,
          "readsGt64msPct vs writesGt64msPct" = 14,
          "readsGt128msPct vs writesGt128msPct" = 15,
          "readsGt256msPct vs writesGt256msPct" = 16,
          "readsGt512msPct vs writesGt512msPct" = 17,
          "readsGt1024msPct vs writesGt1024msPct" = 18,
          "readsGt2048msPct vs writesGt2048msPct" = 19,
          "readsGt4096msPct vs writesGt4096msPct" = 20,
          "reads0_062msPct vs writes0_062msPct" = 21,
          "reads0_125msPct vs writes0_125msPct" = 22,
          "reads0_25msPct vs writes0_25msPct" = 23,
          "reads0_5msPct vs writes0_5msPct" = 24,
          "reads1msPct vs writes1msPct" = 25,
          "reads2msPct vs writes2msPct" = 26,
          "reads4msPct vs writes4msPct" = 27,
          "reads8msPct vs writes8msPct" = 28,
          "reads16msPct vs writes16msPct" = 29,
          "reads32msPct vs writes32msPct" = 30,
          "reads64msPct vs writes64msPct" = 31,
          "reads128msPct vs writes128msPct" = 32,
          "reads256msPct vs writes256msPct" = 33,
          "reads515msPct vs writes515msPct" = 34,
          "reads1024msPct vs writes1024msPct" = 35,
          "reads2048msPct vs writes2048msPct" = 36,
          "reads4096msPct vs writes4096msPct" = 37,
          "reads8192msPct vs writes8192msPct" = 38,
          "reads16384msPct vs writes16384msPct" = 39,
          "reads32768msPct vs writes32768msPct" = 40,
          "reads65536msPct vs writes65536msPct" = 41
        )
      
      ggplotly(
        plot_ly(
          data = read.csv(database[as.numeric(input$in2)]),
          x = read.csv(database[as.numeric(input$in2)])[, xVar],
          y = read.csv(database[as.numeric(input$in2)])[, yVar],
          type = 'scatter',
          mode = 'markers'
        ) %>% layout(
          title = paste0("System ", input$in2),
          xaxis = list(title = sub(" .*", "", input$x)),
          yaxis = list(title = sub(".* ", "", input$x))
        )
      )
    }
    else{
      ggplotly(ggplot(NULL))
    }
  })
})