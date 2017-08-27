library(tidyr)
library(readr)
df <- read_csv("growthRate.csv")
head(df)
df <- df[ which(df$State=='United States' | df$State=='Illinois'),]
head(df)


names(df)[names(df)=="Annua_Q42007"] <- "Annual growth rate\nsince 2007"
names(df)[names(df)=="Q42015_Q42016"] <- "Growth rate,\n2015 to 2016"
names(df)

df_long <- gather(df, set, value, 2:3, factor_key=TRUE)

head(df_long)

# load in ggplot and themes
library(ggplot2)
library(ggthemes)


# grouped bars

#----Set up plot for print and online --------

# widths for pdf and png files are set up so that
# text elements work for print and online. 
# Generally, the pdf will = a 2-column graphic
# that in a pinch could be used in the paper without
# any work on my part as long as it printed in color,
# and the png will be readable on mobile.

# As for height, adjust that as necessary. Look at the
# files you create and see if they need room!

# While working out your plot, leave these items commented out
# so you can see a preview of your graphic in the plots pane
# when you're satisfied with it, then uncomment to save out
# files. Note you can't create pdfs and pngs at the same time
# you'll have to uncomment one and comment out the other.

#dev.cur()
#pdf(file="ggplotGroupedBars.pdf", width = 7, height = 5) 
#png(filename = "laggingincome.png",width = 600, height = 450, units = "px")
#-----Insert plot here -------------

grouped <- ggplot(df_long) + 
  aes(State,
      value,
      fill = set,
      label = value) + 
  geom_bar(stat = "identity", position = position_dodge(width = NULL)) + 
  coord_flip() + theme_fivethirtyeight()

# add all the titles.
grouped <- grouped + labs(
  title="Lagging income growth", # your headline
  subtitle="Illinois lags the national average in personal income \ngrowth since the beginning of the recession in 2007, \nand from 2015 to 2016.",
  x=" ", 
  y="RATE OF GROWTH",
  caption="\nNote: Data is from the fourth quarter of each year and adjusted for inflation.\nSource: The Pew Charitable Trusts")


# This puts the legend horizontally across the top
# you can leave this alone 
grouped <- grouped + 
  theme(legend.position="top", 
        legend.direction="horizontal",
        legend.title = element_blank())

# Here's where we go further in formating the bar values
# you'll need to edit x, y and label with appropriate values
grouped <- grouped + geom_text(
  position = position_dodge(width = 0.9), 
  aes(x = State, 
      y = value - (value * 0.1), 
      vjust = 0.5,
      label = paste0(value,"%")
      ),
  size=5,
  fontface="bold",
  color="white"
)

# Here's where we adapt the theme we're using to work for us
# Can ignore
grouped <- grouped + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 20),
  legend.text=element_text(size=16),
  axis.title=element_text(size=16, face="bold"),
  axis.text=element_text(size=14),
  plot.caption=element_text(size=14, hjust=0)
) + scale_x_discrete(
  labels=c("Illinois","United\nStates")
)

grouped


#----- End plot --------------
# Uncomment the line below when saving pdfs or pngs
#dev.off() 