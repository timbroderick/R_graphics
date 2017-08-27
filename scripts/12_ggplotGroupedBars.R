# The code in this file is described 
# in html files of the same name

# load the libraries 
library(readr)
library(ggplot2)
library(ggthemes)

# bring in the data we worked worked with
df <- read_csv("dfsubset.csv")



#---------------------
# For windows devices only
# windowsFonts(Verdana=windowsFont('Verdana'))

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
      #legend.title=element_text(size = 13,face="bold"),
      legend.text=element_text(size=14.7),
      axis.title=element_text(size=15, face="bold"),
      axis.text=element_text(size=13.5),
      plot.caption=element_text(size=13.5, hjust=0),
      strip.text = element_text(face="bold", size=13.5, hjust=0),
      # This puts the legend across the top
      legend.position="top", 
      legend.direction="horizontal",
      # removes label for legend
      legend.title = element_blank(),
      ...
    )
}

#-----Insert plot here -------------

grouped <- ggplot(df) + 
  aes(x = reorder(Year_Quarter, -sort),
      value,
      fill = set,
      label = value) + 
  geom_bar(stat = "identity", position = position_dodge(width = NULL)) + 
  coord_flip() + theme_gfx()

# add all the titles.
grouped <- grouped + labs(
  title="Response to resistance", # your headline
  subtitle="Elgin police have increased their use of\nnon-lethal force in response to resistance.",
  x="YEAR, QUARTER", 
  y="TYPES OF RESPONSE TO RESISTANCE",
  caption="\nNote: Show of Force and Use of Force are incidents where \npolice only warned or only used force in repsonse to resistance. \nTransition is incidents where police showed then used force. \nSource: Elgin police") +
  guides(fill=guide_legend(reverse=T))

# Here's where we go further in formating the bar values
# you'll need to edit x, y and label with appropriate values
# _____NOTE________
# If you choose to have values on your bars, you'll need to adjust
# the depth of the graphic to accomodate the size of the labels.
# alternatively, you could omit this code section
# and not have the values on the bars.
grouped <- grouped + geom_text(
  position = position_dodge(width = 0.9), 
  aes(x = Year_Quarter, 
      y = value - (value * 0.1), 
      vjust = 0.5,
      label = value),
  size=5,
  fontface="bold",
  color="white"
  )

# Finally, let's make the axis labels better
# Reverse order since we resorted the bars
grouped <- grouped + scale_x_discrete(
  labels=c("4Q","3Q","2Q","2016 1Q","4Q","3Q","2Q","2015 1Q","4Q","3Q","2Q","2014 1Q")
)

# color scheme - comment out for B/W PDF
grouped <- grouped + scale_colour_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") ) + scale_fill_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") )

# make B/W PDF - remember to change name of file!
#grouped <- grouped + scale_colour_grey(start = 0, end = 0.75) + scale_fill_grey(start = 0, end = 0.75)

grouped

#----- End plot --------------


