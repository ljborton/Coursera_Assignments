
        
shinyServer(function(input, output) {
                model <- lm(prestige ~ education, data = Prestige)
                modelpred <- reactive({
                        edInput <- input$slidered
                        predict(model, newdata = data.frame(education = edInput))
                })
                output$plot <- renderPlot({
                        edInput <- input$slidered
                        plot(Prestige$ed, Prestige$prestige, xlab = "Education (Years)", 
                             ylab = "Prestige (Score)", bty = "n", pch = 16,
                             xlim = c(6, 16), ylim = c(14, 88))
                        if(input$showModel){
                            abline(model, col = "red", lwd = 2)
                        }
                        legend(25, 250, c("Model Prediction"), pch = 16, 
                               col = c("red", "blue"), bty = "n", cex = 1.2)
                        points(edInput, modelpred(), col = "red", pch = 16, cex = 2)
                        
                })
                output$pred <- renderText({
                        modelpred()
                })
        })