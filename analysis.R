library(lubridate)
library(splines)
library(plyr)
library(ggplot2)

PvGlmPredict<-function(glm_obj){
    d<-glm_obj$data
    y1<-min(d$year)
    y2<-max(d$year)
    pred <- data.frame(year = y1:y2,hod=12,
                       doy=227)
    pred <- transform(pred, yhat = predict(glm_obj, 
                                           newdata = pred,se.fit=TRUE))
    return(pred)
}

iliamna_counts <- read.csv('~/Arr/PvIliamna/data-open/Iliamna_HS_effort_count_weather.csv')
iliamna_counts$datetime <- as.POSIXct(iliamna_counts$datetime,tz="US/Alaska")

iliamna_counts$year <- as.numeric(format(iliamna_counts$datetime,"%Y"))
iliamna_counts$hod <- as.numeric(format(iliamna_counts$datetime,"%H"))
iliamna_counts$doy<-lubridate::yday(iliamna_counts$datetime)

iliamna_grouped <- ddply(iliamna_counts,.(year,doy),summarize,totalcount = sum(nonpup_count,na.rm=TRUE),hod = mean(ifelse(hod==0,NA,hod)))

iliamna_glm<-glm(totalcount ~ year + doy + bs(hod),
         data=iliamna_grouped,family=quasipoisson(link="log"))

iliamna_pred <- PvGlmPredict(iliamna_glm)

p <- ggplot(data=iliamna_pred) +
    geom_ribbon(aes(year,ymin=exp(yhat.fit-1.96*yhat.se.fit),ymax=exp(yhat.fit+1.96*yhat.se.fit)),alpha=0.2) +
    geom_line(aes(year,exp(yhat.fit)),color='blue') + 
    geom_point(data=iliamna_glm$data,aes(year,totalcount),size=5,position='jitter')

p <- ggplot(data=iliamna_glm$data,aes(hod,totalcount)) + stat_smooth() + geom_point()
p <- ggplot(data=iliamna_glm$data,aes(doy,totalcount)) + stat_smooth() + geom_point()

plot(iliamna_glm$data$hod,iliamna_glm$data$totalcount)