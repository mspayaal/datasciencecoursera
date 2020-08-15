library(shiny)
library(e1071)
library(randomForest)

#  This Shiny app is designed to predict the type of iris flower
#  Species based on the inputs given for four predictors.
#  The four predictors are "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
#  iris data base has been used 

shinyUI(fluidPage(

    titlePanel("Predicting Iris Flower Sepcies based on Predictor Inputs"),
 
# four sliders have been designed to select the values of four predictors
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("Sepal.Length",
                        "Provide length of Sepal",
                        min = 4.3,
                        max = 7.9,
                        value = 6.0),
            sliderInput("Sepal.Width",
                        "Provide width of Sepal",
                        min = 2.0,
                        max = 4.4,
                        value = 3.0),
            sliderInput("Petal.Length",
                       "Provide length of Petal",
                        min = 1.0,
                        max = 6.9,
                       value = 4.0),
            sliderInput("Petal.Width",
                      "Provide length of Petal",
                        min = 0.1,
                        max = 2.5,
                        value = 1.5),
            
  # the prediction is based on two selectable  models 'Trees' and 'Random Forest'
  
             h3("Select the model"),
            
            checkboxInput("showModel1", "Model Trees", value = TRUE),
            checkboxInput("showModel2", "Model Random Forest ", value = TRUE),
            
            submitButton("Submit")
        ),

        
        mainPanel(

# the prediction is one of the three species of 'iris' 
# based on model(s) selected 
            
            h4("Predicted Species from Model Trees :"),
            textOutput("pred1"),
            
            
            h4("Predicted Species from Model Random Forest  :"),
            textOutput("pred2"),
            
            h4(" Reading Predictions for the Iris Species"),
              
              h4("1= setosa, 2= versicolor, 3= virginica")
            
        )
    )
))
