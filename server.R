
library(shiny)


shinyServer(function(input, output) {
    
    library(caret)
    
  # two  models are created based on iris dataset  
    
    model1 <- train(Species ~ .,method="rpart",data=iris)
    model2 <- train(Species ~ .,method="rf",data=iris,prox=TRUE)
    
  # creating a dataframe of inputs
    
   predictOn <-  reactive ({ data.frame(Sepal.Length = input$Sepal.Length,
                           Sepal.Width = input$ Sepal.Width,
                            Petal.Length = input$Petal.Length,
                            Petal.Width = input$Petal.Width,Species = "")
   })
   
   # prediction using the two models  
    model1pred <- reactive({
        predictOn <-  data.frame(Sepal.Length = input$Sepal.Length,
                                             Sepal.Width = input$ Sepal.Width,
                                             Petal.Length = input$Petal.Length,
                                             Petal.Width = input$Petal.Width,Species = "")
    
        predict(model1,newdata = predictOn )
    })
    
    model2pred <- reactive({
        predictOn <-  data.frame(Sepal.Length = input$Sepal.Length,
                                 Sepal.Width = input$ Sepal.Width,
                                 Petal.Length = input$Petal.Length,
                                 Petal.Width = input$Petal.Width,Species = "")
        
        predict(model2,newdata = predictOn)
    })
    
  # rendering the output  

    output$pred1 <- renderText({
        if(input$showModel1){
                    model1pred() 
                    
               } else {
                   print("Model Not Selected")
               }
             })
        
        
    
    output$pred2 <- renderText({
        if(input$showModel2){
            model2pred()  
        } else {
            print("Model Not Selected")
       }
    })
    
    

    })


