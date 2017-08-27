# check libraries
library(readr)
library(rgdal)
library(dplyr)
library(RColorBrewer) # for my color ramp
library(viridis)
library(scales)
library(ggplot2)
library(ggmap)
library(ggthemes)

#---------------------
# This function set styles for the chart
# Be sure to run it before you plot

theme_map <- function(...) {
  theme_fivethirtyeight() +
    theme(
      plot.background = element_rect(fill = "white"),
      plot.title = element_text(size = 24),
      plot.subtitle = element_text(size = 16),
      plot.caption=element_text(size=12, hjust=0),
      legend.position="right", 
      legend.direction="vertical",
      legend.background = element_rect(fill = "white"),
      legend.title=element_text(size=10, face="bold"),
      legend.text=element_text(size=10),
      legend.text.align = 0, # 0 = left, 1 = right
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      panel.grid.major = element_blank(),
      panel.background = element_blank(),
      ...
    )
}
#-----------------
# read in the data

ill_f <- read.csv("ill_f.csv", stringsAsFactors = FALSE)
head(ill_f)
summary(ill_f)
names(ill_f)

summary(ill_f$chg_total)
quantile(ill_f$chg_total, probs = seq(0, 1, .2))

# map using ggplot2
map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = chg_total)
              ) +
  geom_polygon( color = "black", size = 0.25) + coord_map() + theme_map()

map <- map + labs(
  title="title", # your headline
  subtitle="subtitle",
  caption="\nSource: Census.gov",
  fill = "legend\ntitle")

# for a sequential color scheme
map <- map + scale_fill_distiller(palette = "Blues",
                                  direction = 1,
                                  breaks = pretty_breaks(n=7)
                                  )
map

# for a diverging color scheme - needs midpoint and hi/low
map <- map + scale_fill_gradient2(low="#a6611a", 
                                  mid="#ffffcc", 
                                  high="#018571", 
                                  midpoint=0, 
                                  limits=c(-21.2,8.2),
                                  breaks = pretty_breaks(n=7)
                                  )
map

# using viridis color scale
map <- map + scale_fill_viridis(option = "B",# A, B, C or D
                                direction=1,
                                breaks = pretty_breaks(n=7)
                                )
map

dev.off()
?scale_color_viridis
?scale_fill_gradient2
?scale_fill_distiller
