library(gridExtra)
library(ggplot2)
library(plyr)
library(dplyr)


# color code
ccodes <- c('#d73027', '#fc8d59', '#fee08b', '#d9ef8b', '#91cf60', '#1a9850')


# function which plots daily percentage change in 
# Dow Jones Ind. Index for every year
ChangeHeatmap <- function(yeararg){
  
  djindex.close.small <- djindex.close %>% 
    filter(year == as.numeric(yeararg))
  
  ggplot(djindex.close.small, aes(x = week, y = wday)) + 
    geom_tile(aes(fill = change), color = 'black', size = 0.25) +
    scale_fill_gradientn(colors = ccodes, na.value = 'transparent') +
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

# list of years
all_years <- unique(djindex.close$year)

# run ChangeHeatmap function for every year 
# and add generated plot to plot_list
lapply(all_years, ChangeHeatmap) -> plot_list

# render heatmaps in grid of 2 columns
plot_list[["ncol"]] = 2
do.call(grid.arrange, plot_list)
