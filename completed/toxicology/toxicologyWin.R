# load in needed libraries

library(readr)
library(Cairo) # on Mac need to install XQuartz
library(ggplot2)
library(ggthemes)
library(tidyr)

# Uncomment this for windows devices only
# windowsFonts(Verdana=windowsFont('Verdana'))

#---------------------

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

# -------------
# prepare the data

df <- read_csv("tox.csv")

# df is already sorted, create sort column for plotting
df$sort <- seq.int(nrow(df))

# Since totals across counties are so different and
# 2017 is only a portion of the year, we'll make values percents
# so that we can compare across counties and years.
df$Halone <- round((df$Heroin_alone/df$Total)*100, digits=1)
df$Hother <- round((df$Heroin_and_other/df$Total)*100, digits=1)
df$other <- round((df$opioids_without_heroin/df$Total)*100, digits=1)

# get rid of the actual values to make dataframe more manageable
# this doesn't delete them from the .csv file, just from this
# script's memory
df$Heroin_alone <- NULL
df$Heroin_and_other <- NULL
df$opioids_without_heroin <- NULL

# Use tidyr to set up the data for ggplot
dfsub <- gather(df, set, value, 5:7, factor_key=TRUE)

# make sure the Year column is considered a factor
dfsub$Year <- as.factor(dfsub$Year)

# changes labels and sets order of factors
dfsub$set <- factor(dfsub$set, levels = c("other","Hother","Halone"),
                    labels = c(" % Synthetic opiods\n without heroin*"," % Heroin with \n other drugs*    "," % Heroin  \n only"))

dfsub$County <- factor(dfsub$County, levels = c("Cook","DuPage","Kane","Lake","McHenry","Will"),
                    labels = c("     COOK CO. TOTAL DEATHS - 2016: 256, 2017: 100","     DUPAGE CO. TOTAL DEATHS - 2016: 78, 2017 22","     KANE CO. TOTAL DEATHS - 2016: 46, 2017: 24","     LAKE CO. TOTAL DEATHS - 2016: 46, 2017: 17","     MCHENRY CO. TOTAL DEATHS - 2016: 31, 2017: 18","     WILL CO. TOTAL DEATHS - 2016: 74, 2017: 28" ))


#-----Insert plot here -------------

stacked <- ggplot(dfsub) +
  aes(x = reorder(Year, -sort),
      y = value,
      fill = set, 
      label = value) + 
  geom_bar(stat = "identity") + 
  coord_flip() + 
  theme_gfx() +
  # here's where we get fancy. We already have the values grouped
  # as a stacked bar chart, but we also want to group everything
  # by county. The facet command will do that for us.
  facet_wrap(~County,ncol=1)

# add all the titles.
stacked <- stacked + labs(
  title="A turn for the worse", # your headline
  subtitle="Suburban counties are seeing an increase \nin overdose deaths caused by more than \njust heroin. Coroners say fentanyl and \nsynthetic opioids have been contributing \nto more deaths beginning last year.",
  x="YEAR", 
  y="PERCENT OF DEATHS",
  caption="\n* Includes fentanyl and synthetic opioids.\nNote: 2017 numbers are through June 15. Cook County data \nexcludes Chicago.\nDaily Herald Graphic | Sources: County coroners.",
  fill = "OPIOID-RELATED OVERDOSE DEATHS") + 
  # if values were decimal, would be label = percent
  # instead assigns specific text to y axis labels
  scale_y_continuous(label = c("0","25%","50%","75%","100%")) +
  # does a bit more formatting of the legend
  # remember to comment out legend.title = blank
  # in the theme style we set at the top
  guides(fill=guide_legend(reverse=T,
                           title.position="top", 
                           title.hjust = 0.5,
                           keywidth = unit(8, units = "mm")
                           )
         )

# Here's where we go further in formating the bar values
stacked <- stacked + geom_text(
  position = "stack", 
  aes(x = Year, 
      y = value - (value * 0.025), 
      hjust = 1,
      label = paste0(value) ),
  size=5,
  family="Verdana",
  fontface="bold",
  color="white"
)


# color scheme - comment out for B/W PDF
stacked <- stacked + scale_colour_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") ) + scale_fill_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") )
# make B/W PDF - remember to change name of file!
#stacked <- stacked + scale_colour_grey(start = 0, end = 0.75) + scale_fill_grey(start = 0, end = 0.75)

stacked

#----- End and save plot --------------

# save for PDF
ggsave("toxicology.pdf", width = 7, height = 9.5, device=cairo_pdf, units = c("in"), dpi = 300, limitsize = FALSE)

# save for web
ggsave("toxicology.png", width = 7, height = 9.5, device="png", units = c("in"), dpi = 86, limitsize = FALSE)

# This tells us what font is set as the default in our theme
#theme_get()$text
