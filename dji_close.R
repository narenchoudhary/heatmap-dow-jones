library(gridExtra)
library(ggplot2)
library(plyr)
library(dplyr)


# color code
ccodes <- c('#d73027', '#fc8d59', '#fee08b', '#d9ef8b', '#91cf60', '#1a9850')


# function which plots daily closing index in 
# Dow Jones Ind. Index for every year
CloseHeatmap <- function(yeararg) {
  djindex.close.small <- djindex.close %>% 
    filter(year == as.numeric(yeararg))
  ggplot(djindex.close.small, aes(x = week, y = wday)) + 
    geom_tile(aes(fill = close), color = 'black') +
    scale_fill_gradientn(colors = ccodes, na.value = 'transparent') +
    theme_bw() +
    coord_equal() +
    labs(x = NULL, y = NULL, title = paste('Year', unique(djindex.close.small$year))) +
    theme(panel.border = element_blank(),
          panel.grid = element_blank(),
          panel.background = element_blank(),
          legend.position = 'none',
          axis.ticks.y = element_blank(),
          axis.text=element_text(size=5),
          plot.title = element_text(hjust = 0),
          axis.text.y = element_text(hjust = 1)) +
    scale_x_continuous(expand = c(0,0), breaks = seq(0, 54, by = 2))
}


# list of years
all_years <- unique(djindex.close$year)

# run ChangeHeatmap function for every year 
# and add generated plot to plot_list
lapply(all_years, CloseHeatmap) -> plot_list

# render heatmaps in grid of 2 columns
plot_list[["ncol"]] = 2
do.call(grid.arrange, plot_list)
