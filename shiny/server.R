shinyServer(function(input, output) {
    iliamna_years <- iliamna_grouped$year
    # Reactive expression to run the glm for given range of years
    trend_glm <- reactive({
        sub_index <- which(iliamna_years >= input$trend_range[1] & iliamna_years <= input$trend_range[2])
        data<-iliamna_grouped[sub_index,]
        data$year<-as.integer(data$year)
        iliamna_glm<-glm(totalcount ~ year + bs(doy) + bs(hod),
                         data=data,family=quasipoisson(link="log"))
        return(iliamna_glm)
    }) 
    
    pred_glm <- reactive({
        glm_obj <- trend_glm()
        d<-glm_obj$data
        y1<-input$trend_range[1]
        y2<-input$trend_range[2]
        pred <- data.frame(year = y1:y2,hod=as.integer(input$pred_hod),
                           doy=as.integer(input$pred_doy))
        pred <- transform(pred, yhat = predict(glm_obj, 
                                               newdata = pred,se.fit=TRUE))
        return(pred)
    })
    
    output$pred.plot <- renderPlot({
        pred_data <- pred_glm()
        trend_data <- trend_glm()$data
        p <- ggplot(data=pred_data) +
            geom_ribbon(aes(year,ymin=exp(yhat.fit-1.96*yhat.se.fit),ymax=exp(yhat.fit+1.96*yhat.se.fit)),alpha=0.2) +
            geom_line(aes(year,exp(yhat.fit)),color='blue') + 
            geom_point(data=trend_data,aes(year,totalcount,colour=data_source),size=4,,alpha=0.3)
        print(p)
    },height=600)
    
    output$summary <- renderPrint({
        glmObj <- trend_glm()
        summary(glmObj)
    })
    
    output$data_table <- renderTable({
        trend_glm()$data
    })

})