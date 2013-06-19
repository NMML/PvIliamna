library(lubridate)
library(splines)

PvGlmPredict<-function(glm_obj){
    d<-glm_obj$data
    y1<-min(d$year)
    y2<-max(d$year)
    pred <- data.frame(year = y1:y2,hod=12,
                       doy=180)
    pred <- transform(pred, yhat = predict(glm_obj, 
                                           newdata = pred,se.fit=TRUE,type="response"))
    return(pred)
}

iliamna_counts <- read.csv('~/Arr/PvIliamna/data-open/Iliamna_HS_effort_count_weather.csv')
iliamna_counts$datetime <- as.POSIXct(iliamna_counts$datetime,tz="US/Alaska")