# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
library(Cairo)
library(ggplot2)
library(ggthemes)

#---------------------
# Uncomment this for windows devices only
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

df <- read_csv("filename")
head(df)

#-----Insert plot here -------------




#----- End plot --------------

# save for PDF - adjust height
#ggsave("filename.pdf", width = 7, height = X.X, device=cairo_pdf, units = c("in"), dpi = 300, limitsize = FALSE)

# save for web - adjust height
#ggsave("filename.pdf", width = 7, height = X.X, device="png", units = c("in"), dpi = 86, limitsize = FALSE)
