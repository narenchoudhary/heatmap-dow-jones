
wdays <- c('Sun', 'Mon', 'Tue', 'Wed', 'Thurs', 'Fri', 'Sat')
testdf <- data.frame(week = rep(1:52, each = 7), 
                     day = rep(wdays, times = 52))
testdf$close <- NA