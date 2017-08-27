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

pLine <- ggplot(df) +
  aes(x = Year_Quarter, 
      y = value, 
      group = set, 
      color = set) +
  geom_line(stat="identity", 
            size = 1.5) + 
  geom_point(stat="identity", 
             size = 3,
             shape=21,
             fill="white") + 
  theme_gfx()

# Let's customize the x scale
# Remember \n = a line break
pLine <- pLine + scale_x_discrete(
  labels=c("1Q\n2014","2Q","3Q","4Q","1Q\n2015","2Q","3Q","4Q","1Q\n2016","2Q","3Q","4Q")
)

# Let's also customize the y scale
# we set the min and max, then where breaks should be
pLine <- pLine + 
  scale_y_continuous(breaks=c(seq(0,40,5)) )

# add all the titles.
pLine <- pLine + labs(
  title="Response to resistance", # your headline
  subtitle="Elgin police have increased their use of\nnon-lethal force in response to resistance.",
  x="YEAR, QUARTER", 
  y="NUMBER PER QUARTER",
  caption="\nNote: Show of Force and Use of Force are incidents where \npolice only warned or only used force in repsonse to resistance. \nTransition is incidents where police showed then used force. \nSource: Elgin police")

# color scheme - comment out for B/W PDF
pLine <- pLine + scale_colour_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") ) + scale_fill_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") )
# make B/W PDF - remember to change name of file!
#pLine <- pLine + scale_colour_grey(start = 0, end = 0.75) + scale_fill_grey(start = 0, end = 0.75)

pLine


#----- End plot --------------

