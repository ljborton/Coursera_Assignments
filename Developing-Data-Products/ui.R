library(shiny)
library(car)

    shinyUI(fluidPage(
        titlePanel("Predict Prestige from Education"),
            mainPanel(
                tabsetPanel(type = "tabs", 
                            tabPanel("Documentation", h3("Slide the slider bar to adjust 
                    the years of Education.  The plot will show the predicted 
                                    prestige an occupation has based on the years of education 
                                    a person has that holds it.")),
                            tabPanel("Plot", plotOutput("plot"), sliderInput("slidered", 
                    "What is the Education of Occupational Incumbents?", 
                    6, 16, value = 11), checkboxInput("showModel", 
                    "Show/Hide Model", value = TRUE), h3("Predicted Prestige 
                    from Education"), textOutput("pred")
                    
                                )
                                
                        )
                )
        )
    )
        
        
        
        
        
       