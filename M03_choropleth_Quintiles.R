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

ill_f <- read.csv("ill_f.csv", stringsAsFactors = FALSE)
head(ill_f)
summary(ill_f)
names(ill_f)


# ------------
# define theme as a function

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

summary(ill_f$Rchg_65over)
# find breaks
quantile(ill_f$Rchg_65over, probs = seq(0, 1, .2))

# --------------
# define quantiles for data
no_classes <- 5
labels <- c()

quantiles <- quantile(ill_f$Rchg_65over, # data you wish to work with
                      probs = seq(0, 1, length.out = no_classes + 1))

# custom labels
labels <- c()
for(idx in 1:length(quantiles)){
  labels <- c(labels, paste0(round(quantiles[idx], 2), 
                             " to ", 
                             round(quantiles[idx + 1], 2)))
}
labels <- labels[1:length(labels)-1]

# add quantile info to dataset
ill_f$Rchg_65over_quantiles <- cut(ill_f$Rchg_65over, 
                                 breaks = quantiles, 
                                 labels = labels, 
                                 include.lowest = T)

#---------------
# Map using Brewer scales
map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = Rchg_65over_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map() +
  guides(fill = guide_legend(reverse = TRUE))

map <- map + labs(
  title="65 and over", # your headline
  subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  caption="\nSource: Census.gov",
  fill = "PERCENT\nCHANGE")

map <- map + scale_fill_brewer(type = "div", 
                               palette = "BrBG", 
                               direction = 1
)
map
dev.off()

?scale_fill_brewer

#---------------
# Custom diverging color ramp

map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = Rchg_65over_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  title="65 and over", # your headline
  subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  caption="\nSource: Census.gov",
  fill = "PERCENT\nCHANGE")

map <- map + scale_fill_manual(
  values = c("#a6611a", "#dfc27d", "#f6e8c3", "#80cdc1", "#018571")
  ) +
  guides(fill = guide_legend(reverse = TRUE))

map
dev.off()

?colorRampPalette

#--------------------------
# custom legend

labels2 <- c()

# If we just wanted single numbers instead of the range
#for(idx in 1:length(quantiles)){
#  labels2 <- c(labels2,paste0(round(quantiles[idx], 1),
#               "%")
#  )
#}

# If we want the complete range, like "0-50"
for(idx in 1:length(quantiles)){
  labels2 <- c(labels2, paste0(round(quantiles[idx], 1), 
                             " -\n", 
                             round(quantiles[idx + 1], 1),
                             "%"
                             ))
}


labels2 <- labels2[1:length(labels2)-1]
# define a new variable on the data set just as above
ill_f$Rchg_65over_brks <- cut(ill_f$Rchg_65over, 
                     breaks = quantiles, 
                     include.lowest = TRUE,
                     labels = labels2)

brks_scale <- levels(ill_f$Rchg_65over_brks)
# if we needed to reverse the scale somehow
#labels_scale <- rev(brks_scale)

labels_scale <-brks_scale
labels_scale

# now map
map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = Rchg_65over_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  title="65 and over", # your headline
  subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  caption="\nSource: Census.gov",
  fill = "PERCENT CHANGE")

map <- map + 
  theme(legend.position = "top", legend.direction = "horizontal") +
  scale_fill_manual(
    values = c("#a6611a", "#dfc27d", "#f6e8c3", "#80cdc1", "#018571"),
    drop = FALSE,
    labels = labels_scale,
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
      label.position = "bottom"
    )
)

map

dev.off()


# --------------

# Using viridis color scale
map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = Rchg_65over_quantiles)
              ) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  title="65 and over", # your headline
  subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  caption="\nSource: Census.gov",
  fill = "PERCENT\nCHANGE")

# using viridis color scale
map <- map + theme(legend.position = "right") +
  scale_fill_viridis(option = "B",# A, B, C or D
                     direction=1,
                     discrete = T,
                     #breaks = pretty_breaks(n=7),
                     guide = guide_legend(
                       keyheight = unit(5, units = "mm"),
                       title.position = 'top',
                       reverse = T
                       )
                     )

map
dev.off()

?scale_color_viridis

# ---------------------
# Custom legend with viridis color scale

map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = Rchg_65over_quantiles)
) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  title="65 and over", # your headline
  subtitle="Percent change in the rate\nper 1,000 of persons aged 65\nand over, 2010 - 2016",
  caption="\nSource: Census.gov",
  fill = "PERCENT CHANGE")

map <- map + 
  theme(legend.position = "top", legend.direction = "horizontal") +
  scale_fill_manual(
    # viridis, magma, plasma or inferno
    # (#) = number of breaks, [4:8] takes last 5
    values = magma(8)[3:7],
    drop = FALSE,
    labels = labels_scale,
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
      label.position = "bottom"
    )
  )

map

dev.off()



