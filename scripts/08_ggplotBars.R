# The code in this file is described 
# in html files of the same name

library(readr)
library(ggplot2)
library(ggthemes)


#---------------------
# For windows devices only
windowsFonts(Verdana=windowsFont('Verdana'))

# This function set styles for the chart
# Be sure to run it before you plot

theme_gfx <- function(...) {
  theme_set(theme_get() + theme(text = element_text(family = 'Verdana', size= 12, lineheight=0.9))) + 
    theme(
      # edit background colors
      plot.background = element_blank(),
      legend.background = element_blank(),
      panel.background=element_rect(fill="#E5E5E5"),
      strip.background=element_rect(fill="#E5E5E5"),
      # modify grid and tick lines
      panel.grid.major = element_line(size = .6, color="#D2D2D2"),
      panel.grid.minor = element_line(size = .6, color="#D2D2D2", linetype = "dashed"),
      axis.ticks = element_blank(),
      # edit font sizes
      plot.title = element_text(size = 27,face="bold"),
      plot.subtitle = element_text(size = 18),
      legend.title=element_text(size = 13,face="bold"),
      legend.text=element_text(size=14.7),
      axis.title=element_text(size=15, face="bold"),
      axis.text=element_text(size=13.5),
      plot.caption=element_text(size=13.5, hjust=0),
      strip.text = element_text(face="bold", size=13.5, hjust=0),
      # This puts the legend across the top
      legend.position="top", 
      legend.direction="horizontal",
      # removes label for legend
      #legend.title = element_blank(),
      ...
    )
}


#----------------
# Get and prepare the data

df <- read_csv("dfCrime.csv")
df <-df[order(df$Year_Quarter),]
# add column containing the row number. 
df$sort <- seq.int(nrow(df)) 


#-----Insert plot here -------------

basebar <- ggplot(df) + 
  aes(x = reorder(Year_Quarter, -sort), 
      y = Total_RTR, 
      fill = factor(year)) +
  geom_bar(stat="identity") + 
  coord_flip() + theme_gfx()

# add all the titles.
basebar <- basebar + labs(
  title="Response to resistance",
  subtitle="Elgin police have increased their use of\nnon-lethal force in response to resistance.",
  x="YEAR, QUARTER", 
  y="RESPONSE TO RESISTANCE INSTANCES",
  caption="\nSource: Elgin police")

# Remove lengend
basebar <- basebar + theme(legend.position="None")

# Better x labels
basebar <- basebar + scale_x_discrete(
  labels=c("4Q","3Q","2Q","2016 1Q","4Q","3Q","2Q","2015 1Q","4Q","3Q","2Q","2014 1Q")
)

# add values to the bars
basebar <- basebar + geom_text(
  position = "stack", 
  aes(x = Year_Quarter, 
      y = Total_RTR - (Total_RTR * 0.025), 
      hjust = 1,
      label = Total_RTR),
  size=5,
  family="Verdana",
  fontface="bold",
  color="white"
)

# color scheme
basebar <- basebar + scale_colour_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") ) + scale_fill_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") )

basebar

#----- End plot --------------

# Grab the data we used and save it for later
dfrtr <- subset(df, select = c("year","Year_Quarter","Total_RTR","sort"))
write_csv(dfrtr,"dfRTR.csv")
