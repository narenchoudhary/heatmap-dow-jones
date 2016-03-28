library(gridExtra)
library(ggplot2)
library(plyr)
library(dplyr)

YearHeatmapClose <- function(yeararg) {
  djindex.close.small <- djindex.close %>% 
    filter(year == as.numeric(yeararg))
  ggplot(djindex.close.small, aes(x = week, y = wday)) + 
    geom_tile(aes(fill = close), color = 'black') +
    scale_fill_gradient(low='red', high = 'green', na.value = 'white') +
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

all_years <- unique(djindex.close$year)

lapply(all_years, YearHeatmap) -> plot_list
plot_list[["ncol"]] = 2
do.call(grid.arrange, plot_list)
