library(shiny)
library(lubridate)
library(splines)
library(plyr)

# Define server logic for slider examples
shinyServer(function(input, output) {
    
    iliamna_years <- as.numeric(format(iliamna_counts$datetime,"%Y"))
    
    # Reactive expression to run the glm for given range of years
    trend_glm <- reactive({
        sub_index <- which(iliamna_years >= input$trend_range[1] & iliamna_years <= input$trend_range[2])
        data<-iliamna_counts[sub_index,]
        res<-glm(nonpup_count ~ year + doy + bs(hod),
                 data=data,family=quasipoisson(link="log"))
    }) 
    
    # Generate a summary of the glm
    output$summary <- renderPrint({
        glmObj <- trend_glm()
        summary(glmObj)
    })
    
    output$pred.table <- renderTable({
        glmObj <- trend_glm()
        pred <- PvGlmPredict(glmObj)
        pred
    })
    
    output$pred.plot <- renderPlot({
        glmObj <- trend_glm()
        pred <- PvGlmPredict(glmObj)
        plot(glmObj$data$year,glmObj$data$nonpup_count)
    })
})