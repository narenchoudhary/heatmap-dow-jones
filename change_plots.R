library(gridExtra)
library(ggplot2)
library(plyr)
library(dplyr)


YearHeatmapChange <- function(yeararg){
  djindex.close.small <- djindex.close %>% 
    filter(year == as.numeric(yeararg))
  ggplot(djindex.close.small, aes(x = week, y = wday)) + 
    geom_tile(aes(fill = change), color = 'black') +
    # scale_fill_gradient2(low='#d73027', high = '#1a9850', na.value = 'white') +
    scale_fill_gradientn(colors = ccodes, na.value = 'white') +
    theme_bw() +
    coord_equal() +
    labs(x = NULL, y = as.character(yeararg)) +
    theme(panel.border = element_blank(),
          panel.grid = element_blank(),
          panel.background = element_blank(),
          axis.text = element_blank(),
          legend.position = 'none',
          axis.ticks = element_blank(),
          axis.title.y = element_text(margin = margin(0,0,0,0))) +
    scale_x_continuous(expand = c(0,0), breaks = seq(0, 54, by = 2)) +
    scale_y_discrete(limits = rev(c('Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat')))
}

ccodes <- c('#d73027', '#fc8d59', '#fee08b', '#d9ef8b', '#91cf60', '#1a9850')
all_years <- unique(djindex.close$year)

lapply(all_years, YearHeatmapChange) -> plot_list
plot_list[["ncol"]] = 2
do.call(grid.arrange, plot_list)
