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
  theme_set(theme_get() + theme(text = element_text(family = 'Verdana', size= 12, lineheight=0.9))) + 
    theme(
      # edit background colors and elements
      plot.background = element_blank(),
      legend.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_blank(),
      axis.ticks = element_blank(),
      axis.text = element_blank(),
      axis.title = element_blank(),
      # edit font sizes
      plot.title = element_text(size = 27,face="bold"),
      plot.subtitle = element_text(size = 18),
      legend.title=element_text(size = 13,face="bold"),
      legend.text=element_text(size=14.7),
      legend.text.align = 0, # 0 = left, 1 = right
      plot.caption=element_text(size=13.5, hjust=0),
      strip.text = element_text(face="bold", size=13.5, hjust=0),
       ...
    )
}

#-----------------
# read in the data

ill_f <- read.csv("data/ill_f.csv", stringsAsFactors = FALSE)
head(ill_f)
summary(ill_f)
names(ill_f)

co6 <- read.csv("data/counties6.csv", stringsAsFactors = FALSE)

#----------------------------------
#---------- 2015 total crash rate ------
#----------------------------------

# see where the quantiles are for total_crashes_2015
quantile(ill_f$total_rate_2015, probs = seq(0, 1, .2), na.rm=TRUE)

# define quantiles for data
no_classes <- 5
labels <- c()

quantiles <- quantile(ill_f$total_rate_2015, # data you wish to work with
                      probs = seq(0, 1, length.out = no_classes + 1),
                      na.rm=TRUE)

# custom labels
labels <- c()
for(idx in 1:length(quantiles)){
  #labels <- c(labels, paste0(round(quantiles[idx], 2), " to ", round(quantiles[idx + 1], 2)))
  labels <- c(labels, paste0(round(quantiles[idx], 2)))
}
labels <- labels[1:length(labels)-1]

# add quantile info to dataset
ill_f$total_rate_2015_quantiles <- cut(ill_f$total_rate_2015, 
                                   breaks = quantiles, 
                                   labels = labels, 
                                   include.lowest = T)

# now map

map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = total_rate_2015_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  #title="Total number of crashes", # your headline
  #subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  #caption="\nSource: Census.gov",
  fill = "2015 crash rate"
  )

map <- map + 
  theme(legend.position = "top", legend.direction = "horizontal") +
  scale_fill_manual(
  values = c("#a6611a", "#dfc27d", "#f6e8c3", "#80cdc1", "#018571"),
  guide = guide_legend(
    direction = "horizontal",
    keyheight = unit(2, units = "mm"),
    keywidth = unit(75 / length(labels), units = "mm"),
    title.position = 'top',
    # I shift the labels around, the should be placed 
    # exactly at the right end of each legend key
    title.hjust = 0.5,
    #label.hjust = 1,
    nrow = 1,
    byrow = T,
    # Can reverse the legend if that's clearer
    reverse = F,
    label.position = "bottom")
)

map <- map + geom_polygon(data = co6, aes(x=long, y = lat, group = group),
                          fill = NA, color = "blue", size = 0.25)

map

#----------------------------------
#---------- 2015 pedestrian crash rate ------
#----------------------------------


# define quantiles for data
no_classes <- 5
labels <- c()

quantiles <- quantile(ill_f$ped_rate_2015, # data you wish to work with
                      probs = seq(0, 1, length.out = no_classes + 1),
                      na.rm=TRUE)

# custom labels
labels <- c()
for(idx in 1:length(quantiles)){
  #labels <- c(labels, paste0(round(quantiles[idx], 2), " to ", round(quantiles[idx + 1], 2)))
  labels <- c(labels, paste0(round(quantiles[idx], 2)))
}
labels <- labels[1:length(labels)-1]

# add quantile info to dataset
ill_f$ped_rate_2015_quantiles <- cut(ill_f$ped_rate_2015, 
                                       breaks = quantiles, 
                                       labels = labels, 
                                       include.lowest = T)

# now map

map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = ped_rate_2015_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  #title="Total number of crashes", # your headline
  #subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  #caption="\nSource: Census.gov",
  fill = "2015 pedestrian crash rate"
)

map <- map + 
  theme(legend.position = "top", legend.direction = "horizontal") +
  scale_fill_manual(
    values = c("#a6611a", "#dfc27d", "#f6e8c3", "#80cdc1", "#018571"),
    guide = guide_legend(
      direction = "horizontal",
      keyheight = unit(2, units = "mm"),
      keywidth = unit(75 / length(labels), units = "mm"),
      title.position = 'top',
      # I shift the labels around, the should be placed 
      # exactly at the right end of each legend key
      title.hjust = 0.5,
      #label.hjust = 1,
      nrow = 1,
      byrow = T,
      # Can reverse the legend if that's clearer
      reverse = F,
      label.position = "bottom")
  )

map <- map + geom_polygon(data = co6, aes(x=long, y = lat, group = group),
                          fill = NA, color = "blue", size = 0.25)

map


#----------------------------------
#---------- 2015 cycling crash rate ------
#----------------------------------

# define quantiles for data
no_classes <- 5
labels <- c()

quantiles <- quantile(ill_f$cycle_rate_2015, # data you wish to work with
                      probs = seq(0, 1, length.out = no_classes + 1),
                      na.rm=TRUE)

# custom labels
labels <- c()
for(idx in 1:length(quantiles)){
  #labels <- c(labels, paste0(round(quantiles[idx], 2), " to ", round(quantiles[idx + 1], 2)))
  labels <- c(labels, paste0(round(quantiles[idx], 2)))
}
labels <- labels[1:length(labels)-1]

# add quantile info to dataset
ill_f$cycle_rate_2015_quantiles <- cut(ill_f$cycle_rate_2015, 
                                     breaks = quantiles, 
                                     labels = labels, 
                                     include.lowest = T)

# now map

map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = cycle_rate_2015_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  #title="Total number of crashes", # your headline
  #subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  #caption="\nSource: Census.gov",
  fill = "2015 cycling crash rate"
)

map <- map + 
  theme(legend.position = "top", legend.direction = "horizontal") +
  scale_fill_manual(
    values = c("#a6611a", "#dfc27d", "#f6e8c3", "#80cdc1", "#018571"),
    guide = guide_legend(
      direction = "horizontal",
      keyheight = unit(2, units = "mm"),
      keywidth = unit(75 / length(labels), units = "mm"),
      title.position = 'top',
      # I shift the labels around, the should be placed 
      # exactly at the right end of each legend key
      title.hjust = 0.5,
      #label.hjust = 1,
      nrow = 1,
      byrow = T,
      # Can reverse the legend if that's clearer
      reverse = F,
      label.position = "bottom")
  )

map <- map + geom_polygon(data = co6, aes(x=long, y = lat, group = group),
                          fill = NA, color = "blue", size = 0.25)

map

#----------------------------------
#---------- crash rate change, 2014-2015 ------
#----------------------------------

ill_f$chg1415 <- ill_f$total_rate_2015 - ill_f$total_rate_2014

# define quantiles for data
no_classes <- 5
labels <- c()

quantiles <- quantile(ill_f$chg1415, # data you wish to work with
                      probs = seq(0, 1, length.out = no_classes + 1),
                      na.rm=TRUE)

# custom labels
labels <- c()
for(idx in 1:length(quantiles)){
  #labels <- c(labels, paste0(round(quantiles[idx], 2), " to ", round(quantiles[idx + 1], 2)))
  labels <- c(labels, paste0(round(quantiles[idx], 2)))
}
labels <- labels[1:length(labels)-1]

# add quantile info to dataset
ill_f$chg1415_quantiles <- cut(ill_f$chg1415, 
                                       breaks = quantiles, 
                                       labels = labels, 
                                       include.lowest = T)

# now map

map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = chg1415_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  #title="Total number of crashes", # your headline
  #subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  #caption="\nSource: Census.gov",
  fill = "Change in total rate, 2014-2015"
)

map <- map + 
  theme(legend.position = "top", legend.direction = "horizontal") +
  scale_fill_manual(
    values = c("#a6611a", "#dfc27d", "#f6e8c3", "#80cdc1", "#018571"),
    guide = guide_legend(
      direction = "horizontal",
      keyheight = unit(2, units = "mm"),
      keywidth = unit(75 / length(labels), units = "mm"),
      title.position = 'top',
      # I shift the labels around, the should be placed 
      # exactly at the right end of each legend key
      title.hjust = 0.5,
      #label.hjust = 1,
      nrow = 1,
      byrow = T,
      # Can reverse the legend if that's clearer
      reverse = F,
      label.position = "bottom")
  )

map <- map + geom_polygon(data = co6, aes(x=long, y = lat, group = group),
                          fill = NA, color = "blue", size = 0.25)

map

#----------------------------------
#---------- ped crash rate change, 2014-2015 ------
#----------------------------------

ill_f$pedchg1415 <- ill_f$ped_rate_2015 - ill_f$ped_rate_2014

# define quantiles for data
no_classes <- 5
labels <- c()

quantiles <- quantile(ill_f$pedchg1415, # data you wish to work with
                      probs = seq(0, 1, length.out = no_classes + 1),
                      na.rm=TRUE)

# custom labels
labels <- c()
for(idx in 1:length(quantiles)){
  #labels <- c(labels, paste0(round(quantiles[idx], 2), " to ", round(quantiles[idx + 1], 2)))
  labels <- c(labels, paste0(round(quantiles[idx], 2)))
}
labels <- labels[1:length(labels)-1]

# add quantile info to dataset
ill_f$pedchg1415_quantiles <- cut(ill_f$pedchg1415, 
                               breaks = quantiles, 
                               labels = labels, 
                               include.lowest = T)

# now map

map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = pedchg1415_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  #title="Total number of crashes", # your headline
  #subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  #caption="\nSource: Census.gov",
  fill = "Change in pedestrian rate, 2014-2015"
)

map <- map + 
  theme(legend.position = "top", legend.direction = "horizontal") +
  scale_fill_manual(
    values = c("#a6611a", "#dfc27d", "#f6e8c3", "#80cdc1", "#018571"),
    guide = guide_legend(
      direction = "horizontal",
      keyheight = unit(2, units = "mm"),
      keywidth = unit(75 / length(labels), units = "mm"),
      title.position = 'top',
      # I shift the labels around, the should be placed 
      # exactly at the right end of each legend key
      title.hjust = 0.5,
      #label.hjust = 1,
      nrow = 1,
      byrow = T,
      # Can reverse the legend if that's clearer
      reverse = F,
      label.position = "bottom")
  )

map <- map + geom_polygon(data = co6, aes(x=long, y = lat, group = group),
                          fill = NA, color = "blue", size = 0.25)

map

#----------------------------------
#---------- cyclist crash rate change, 2014-2015 ------
#----------------------------------

ill_f$cyclechg1415 <- ill_f$cycle_rate_2015 - ill_f$cycle_rate_2014

# define quantiles for data
no_classes <- 5
labels <- c()

quantiles <- quantile(ill_f$cyclechg1415, # data you wish to work with
                      probs = seq(0, 1, length.out = no_classes + 1),
                      na.rm=TRUE)

# custom labels
labels <- c()
for(idx in 1:length(quantiles)){
  #labels <- c(labels, paste0(round(quantiles[idx], 2), " to ", round(quantiles[idx + 1], 2)))
  labels <- c(labels, paste0(round(quantiles[idx], 2)))
}
labels <- labels[1:length(labels)-1]

# add quantile info to dataset
ill_f$cyclechg1415_quantiles <- cut(ill_f$cyclechg1415, 
                                  breaks = quantiles, 
                                  labels = labels, 
                                  include.lowest = T)

# now map

map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = cyclechg1415_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  #title="Total number of crashes", # your headline
  #subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  #caption="\nSource: Census.gov",
  fill = "Change in cyclist rate, 2014-2015"
)

map <- map + 
  theme(legend.position = "top", legend.direction = "horizontal") +
  scale_fill_manual(
    values = c("#a6611a", "#dfc27d", "#f6e8c3", "#80cdc1", "#018571"),
    guide = guide_legend(
      direction = "horizontal",
      keyheight = unit(2, units = "mm"),
      keywidth = unit(75 / length(labels), units = "mm"),
      title.position = 'top',
      # I shift the labels around, the should be placed 
      # exactly at the right end of each legend key
      title.hjust = 0.5,
      #label.hjust = 1,
      nrow = 1,
      byrow = T,
      # Can reverse the legend if that's clearer
      reverse = F,
      label.position = "bottom")
  )

map <- map + geom_polygon(data = co6, aes(x=long, y = lat, group = group),
                          fill = NA, color = "blue", size = 0.25)

map