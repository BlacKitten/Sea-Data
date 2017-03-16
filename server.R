library(shiny)
library(plotly)
# Define server logic required to draw a histogram
shinyServer(function(input, output) { 
  
  database <- Sys.glob("*-perform.csv")
  sum <- read.csv("perform-summary.csv")
  
  output$variables <- renderPrint({read.csv(database[1])[0,]})
  output$model <- renderPrint({table(sum[,3])})
  output$company <- renderPrint({table(sum[,2])})
  
  output$writeSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(12:41)])}
    else "System ID does not exist."
  })
  output$readSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(42:70)])}
    else "System ID does not exist."
  })
  output$totalSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(71:99)])}
    else "System ID does not exist."   
  })
  output$bandwidthSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(100:102)])}
    else "System ID does not exist." 
  })
  output$ioSummary <- renderPrint({
    if(!is.na(as.numeric(input$choice)) && as.numeric(input$choice) > 0 && as.numeric(input$choice) <= length(database)){
      summary(read.csv(database[as.numeric(input$choice)])[,c(109:111)])}
    else "System ID does not exist."      
  })
  
  output$plot32 <- renderPlotly({
    if(!is.na(as.numeric(input$input32)) && as.numeric(input$input32) > 0 && as.numeric(input$input32) <= length(database)){
      ggplotly(ggplot(read.csv(database[as.numeric(input$input32)]), aes(read.csv(database[as.numeric(input$input32)])[,42], read.csv(database[as.numeric(input$input32)])[,13])) +
        geom_point(shape=1, color= ("#44abff")) + 
        labs(title = "readsGt32msPct vs writesGt32msPct", x = "readsGt32msPct", y = "writesGt32msPct") +
        theme(plot.title = element_text(size = 16), axis.title.x = element_text(size = 16), axis.title.y = element_text(size = 16)))
      }
     else{
       ggplotly(ggplot(NULL))  
     }
  })
  
  output$plot32_ <- renderPlotly({
    if(!is.na(as.numeric(input$input32_)) && as.numeric(input$input32_) > 0 && as.numeric(input$input32_) <= length(database)){
      ggplotly(ggplot(read.csv(database[as.numeric(input$input32_)]), aes(read.csv(database[as.numeric(input$input32_)])[,42], read.csv(database[as.numeric(input$input32_)])[,13])) +
         geom_point(shape=1, color= ("#44abff")) + 
         labs(title = "readsGt32msPct vs writesGt32msPct", x = "readsGt32msPct", y = "writesGt32msPct") +
         theme(plot.title = element_text(size = 16), axis.title.x = element_text(size = 16), axis.title.y = element_text(size = 16)))
    }
    else{
      ggplotly(ggplot(NULL))  
    }
  })
  
  output$customPlot1 <- renderPlotly({
    if(!is.na(as.numeric(input$in1)) && as.numeric(input$in1) > 0 && as.numeric(input$in1) <= length(database)){
      xVar <- switch(input$x, "readsGt32msPct" = 42, "writesGt32msPct" = 13, "readsGt64msPct" = 43, "writesGt64msPct" = 14)
      yVar <- switch(input$y, "readsGt32msPct" = 42, "writesGt32msPct" = 13, "readsGt64msPct" = 43, "writesGt64msPct" = 14)
      
      ggplotly(ggplot(read.csv(database[as.numeric(input$in1)]), aes(read.csv(database[as.numeric(input$in1)])[,xVar], read.csv(database[as.numeric(input$in1)])[,yVar])) +
         geom_point(shape=1, color= ("#44abff")) + 
         labs(title = paste0(input$x, " vs ", input$y), x = input$x, y = input$y) +
         theme(plot.title = element_text(size = 16), axis.title.x = element_text(size = 16), axis.title.y = element_text(size = 16)))
    }
    else{
      ggplotly(ggplot(NULL))  
    }
  })
  
  output$customPlot2 <- renderPlotly({
    if(!is.na(as.numeric(input$in2)) && as.numeric(input$in2) > 0 && as.numeric(input$in2) <= length(database)){
      xVar <- switch(input$x, "readsGt32msPct" = 42, "writesGt32msPct" = 13, "readsGt64msPct" = 43, "writesGt64msPct" = 14)
      yVar <- switch(input$y, "readsGt32msPct" = 42, "writesGt32msPct" = 13, "readsGt64msPct" = 43, "writesGt64msPct" = 14)
      
      ggplotly(ggplot(read.csv(database[as.numeric(input$in2)]), aes(read.csv(database[as.numeric(input$in2)])[,xVar], read.csv(database[as.numeric(input$in2)])[,yVar])) +
         geom_point(shape=1, color= ("#44abff")) + 
         labs(title = paste0(input$x, " vs ", input$y), x = input$x, y = input$y) +
         theme(plot.title = element_text(size = 16), axis.title.x = element_text(size = 16), axis.title.y = element_text(size = 16)))
    }
    else{
      ggplotly(ggplot(NULL))  
    }
  })
})