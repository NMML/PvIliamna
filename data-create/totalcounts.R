library(lubridate)

if (!file.exists("data-open/iliamna_totalcounts.csv")) {
  stop("iliamna_totalcounts.csv file is not available")
}

iliamna_totalcounts <- read.csv("data-open/iliamna_totalcounts.csv",
                                stringsAsFactors = FALSE)

iliamna_totalcounts <- within(iliamna_totalcounts, {
       datetime <- ymd_hms(datetime, tz="America/Anchorage")
       agency <- as.factor(agency)
       observer <- as.factor(observer)
       airtemp <- as.factor(airtemp)
       windspeed <- as.factor(windspeed)
       winddirection <- as.factor(winddirection)
       skycondition <- as.factor(skycondition)
       precip <- as.factor(precip)
       })

save(iliamna_totalcounts, file = "data/iliamna_totalcounts.rdata")
