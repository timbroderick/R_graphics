library(tidyr)
library(readr)

# ------------
# define theme as a function - can ignore but need to 'run' this 
# do not change unless you understand what you're changing

theme_gfx <- function(...) {
  theme_fivethirtyeight() +
    theme(
      plot.background = element_rect(fill = "white"),
      legend.background = element_rect(fill = "white"),
      plot.title = element_text(size = 30),
      plot.subtitle = element_text(size = 18),
      legend.text=element_text(size=15),
      axis.title=element_text(size=15, face="bold"),
      axis.text=element_text(size=13),
      plot.caption=element_text(size=12, hjust=0),
      # This puts the legend across the top
      legend.position="top", 
      legend.direction="horizontal",
      # removes label for legend
      legend.title = element_blank(),
      ...
    )
}

# --------------

# get data
df <- read_csv("growthRate.csv")
head(df)
# sort by a specific column, not alphabetically by name
dfsort <-df[order(df$Annua_Q42007),]
head(dfsort)
# add column containing the row number. We can use this to sort later
dfsort$sort <- seq.int(nrow(dfsort)) 
head(dfsort)

# Rename column names to be more descriptive for use in legend
names(dfsort)[names(dfsort)=="Annua_Q42007"] <- "Annual growth rate\nsince 2007"
names(dfsort)[names(dfsort)=="Q42015_Q42016"] <- "Growth rate,\n2015 to 2016"
names(dfsort)

# now use tidyr to make data "long", not wide
# gather(df name, name of factor column, name of column with values,
# columns to put in value column, factor_key=TRUE)
df_long <- gather(dfsort, set, value, 2:3, factor_key=TRUE)
# compare to dfsort to see how this changed
head(df_long)

# load in ggplot and themes
library(ggplot2)
library(ggthemes)

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
#pdf(file="laggingincome.pdf", width = 7, height = 14) 
#png(filename = "laggingincome.png",width = 600, height = 1000, units = "px")
#-----Insert plot here -------------

grouped <- ggplot(df_long) + 
  aes(x = reorder(State, sort), # sort 'State' column by 'sort' column
      value,
      fill = set,
      label = value) + 
  # position_dodge makes grouped bars
  geom_bar(stat = "identity", position = position_dodge(width = NULL)) + 
  # make bars horizontal, apply theme
  coord_flip() + theme_gfx()

# add all the titles.
grouped <- grouped + labs(
  title="Lagging income growth", # your headline
  subtitle="Illinois lags the national average in personal\nincome growth since the beginning of the \n2007 recession, and from 2015 to 2016.",
  x=" ", 
  y="% RATE OF GROWTH",
  caption="\nNote: Data is from the fourth quarter of each year and adjusted\nfor inflation. | Source: The Pew Charitable Trusts"
  ) + 
  # if values were decimal, would be label = percent
  # instead assigns specific text to y axis labels
  scale_y_continuous(label = c("-2%","0","2%","4%")) + 
  # search for label term, replace with and make bold
  scale_x_discrete(labels=c("United States"=expression(bold("United States")),
                            "Illinois"=expression(bold("Illinois")),
                            parse=TRUE))
grouped


#----- End plot --------------
# Uncomment the line below when saving pdfs or pngs
#dev.off() 