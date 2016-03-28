# Prepare data

library(plyr) # Data manipulation
library(dplyr) # Data manipulation
library(lubridate) # Date Handling
library(zoo) # Date Handling
library(quantmod) # For downloading data from Yahoo! finance
library(ggplot2) 


if(!exists("DJI"))
  getSymbols("^DJI",src="yahoo", from='1995-01-01', to='2008-12-31')
# convert to data-frame
djindex <- data.frame(date=index(DJI), coredata(DJI))
# keep only closing value of DJI 
djindex.close <- djindex %>% select(date, DJI.Close)
# calcualte change from previous date
djindex.close$change <- (djindex.close$DJI.Close/lag(djindex.close$DJI.Close, 1) - 1)*100
# set day1 change to be zero
djindex.close$change[1] <- 0

djindex.close.test <- zoo(djindex.close[,-1], djindex.close[,1])

# add mising dates
new_start <- as.Date('1995-01-01', '%Y-%m-%d')
new_end <- as.Date('2008-12-31', '%Y-%m-%d')
new_seq <- seq(new_start, new_end, by = 'day')
djindex.close <- merge(djindex.close.test, zoo(order.by = new_seq), all = TRUE)

# convert to data-frame
djindex.close <- data.frame(date=index(djindex.close), coredata(djindex.close))

names(djindex.close) <- c('date', 'close', 'change')
# add year, month, day and weekday cols
djindex.close$year <- year(as.POSIXlt(djindex.close$date))
djindex.close$month <- month(as.POSIXlt(djindex.close$date), label = T)
djindex.close$wday <- wday(as.POSIXlt(djindex.close$date), label = T)
djindex.close$day <- day(as.POSIXlt(djindex.close$date))
djindex.close$week <- as.numeric(format(djindex.close$date, "%U")) + 1
