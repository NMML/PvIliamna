library(lubridate)
library(dplyr)

if (!file.exists("data-open/iliamna_totalcounts.csv")) {
  stop("iliamna_totalcounts.csv file is not available")
}

iliamna_totalcounts <- read.csv("data-open/iliamna_totalcounts.csv",
                                stringsAsFactors = FALSE)

iliamna_totalcounts <- transmute(iliamna_totalcounts,
       datetime = ymd_hms(datetime, tz="America/Anchorage"),
       datasource = as.factor(datasource),
       observer = as.factor(observer),
       adulttotal,puptotal,
       airtemp = as.factor(airtemp),
       windspeed = as.factor(windspeed),
       winddirection = as.factor(winddirection),
       skycondition = as.factor(skycondition),
       precip = as.factor(precip),
       notes = as.character(notes)
       )

save(iliamna_totalcounts, file = "data/iliamna_totalcounts.rdata")
