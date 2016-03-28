
# script for plotting example plot with
# random data for testing purposes
library(lubridate)

# year for which plot is to be made
year.arg <- 2000
# first day of year
year_start <- paste0(year.arg, '-01-01')
# last day of year
year_end <- paste0(year.arg, '-12-31')

date.seq <- seq(from  = as.Date(year_start, '%Y-%m-%d'),
                to = as.Date(year_end, '%Y-%m-%d'),
                by = 'day')

# create data-frame
example <- data.frame(date = date.seq, change = rnorm(length(date.seq)))
example$year <- year(example$date)
example$month <- month(example$date, label = T)
example$day <- day(example$date)
example$week <- as.numeric(format(example$date, "%U")) + 1
example$wday <- wday(example$date, label = T)

# No index repoting on sSaturday and Sunday
example$change[example$wday == 'Sun' | example$wday == 'Sat'] <- NA

ccodes <- c('#d73027', '#fc8d59', '#fee08b', '#d9ef8b', '#91cf60', '#1a9850')

p <- ggplot(example, aes(x = week, y = wday, fill = change)) + 
  geom_tile(color = 'black') +
  scale_fill_gradientn(colours = ccodes, na.value = 'transparent') +
  theme_bw() +
  coord_equal() +
  theme(panel.border = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        legend.position = 'none',
        axis.ticks = element_blank()) +
  labs(x = NULL, y = NULL, title = paste('Year', unique(example$year))) +
  scale_x_continuous(expand = c(0,0), breaks = seq(0, 54, by = 1)) +
  scale_y_discrete(limits = rev(c('Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat')))