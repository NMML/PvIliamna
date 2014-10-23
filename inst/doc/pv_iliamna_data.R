## ----,echo=FALSE, message=FALSE------------------------------------------
library(dplyr)
library(PvIliamna)
library(lubridate)
data(iliamna_totalcounts)
data(iliamna_waypoints)

## ----sum-table,results='asis',echo=FALSE,message=FALSE-------------------
library(knitr)

counts_df <- tbl_df(iliamna_totalcounts)

by_agency_year <- group_by(counts_df,data_source = agency,year = as.factor(year(datetime)))
by_agency_year <- arrange(by_agency_year,agency,year(datetime))
sum_tbl <- summarize(by_agency_year,
          first_survey = as.character(min(as.Date(datetime))),
          last_survey = as.character(max(as.Date(datetime))),
          n_surveys = n())
names(sum_tbl) <- c("Data Source","Year","First Survey","Last Survey","No. of Surveys")

kable(sum_tbl,caption = c('Summary of Lake Iliamna aerial surveys conducted across various agencies and researchers'), include.rownames=FALSE)

## ----haul-out-map, echo=FALSE,message=FALSE,warning=FALSE,out.extra='style="float:left;"',fig.cap='Location of harbor seal haul-out sites in Iliamna Lake, Alaska'----
library(ggmap)

wpts <- as(iliamna_waypoints, 'data.frame')

il_base <- get_map(location=c(lon=median(wpts$x),lat=median(wpts$y)),
                   maptype="terrain", color="bw")

p <- ggmap(il_base,extent="device") + geom_point(data=wpts, aes(x=x,y=y,colour="red"), size=3,show_guide=FALSE) + geom_point(data=wpts,aes(x=x,y=y),size=1)
p

## ----install-github-example,eval=FALSE-----------------------------------
#  library(devtools)
#  devtools::install_github("NMML/PvIliamna")

## ----metadata-print, eval=FALSE------------------------------------------
#  library(rjsonlite)
#  fromJSON(system.file("metadata", "PvIliamna_CommonCore.json", package="PvIliamna"))

