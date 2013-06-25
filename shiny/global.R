library(lubridate)
library(splines)
library(plyr)
library(shiny)
library(ggplot2)

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

# path to data file when on remote server
data_file <- 'data-open/Iliamna_HS_effort_count_weather.csv'

#check for data file in remote server path first. if not there, load local path
if (file.exists(data_file)){
    iliamna_counts <- read.csv(data_file)
} else {
    iliamna_counts <- read.csv('../data-open/Iliamna_HS_effort_count_weather.csv')
}


iliamna_counts$datetime <- as.POSIXct(iliamna_counts$datetime,tz="US/Alaska")

iliamna_counts$year <- as.numeric(format(iliamna_counts$datetime,"%Y"))
iliamna_counts$hod <- as.numeric(format(iliamna_counts$datetime,"%H"))
iliamna_counts$doy<-lubridate::yday(iliamna_counts$datetime)

iliamna_grouped <- ddply(iliamna_counts,.(year,doy,data_source),summarize,totalcount = sum(nonpup_count,na.rm=TRUE),hod = mean(ifelse(hod==0,NA,hod)))
iliamna_grouped$year <- as.integer(iliamna_grouped$year)
iliamna_grouped$hod <- as.integer(iliamna_grouped$hod)
iliamna_grouped$doy <- as.integer(iliamna_grouped$doy)
iliamna_grouped$data_source <- factor(iliamna_grouped$data_source,levels=c('NOAA-NMML','Pebble-ABR','ADFG','Mathisen-Kline'))