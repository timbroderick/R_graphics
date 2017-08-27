# The code in this file is described 
# in an html file of the same name

# load the libraries 
library(readr)
library(ggplot2)
library(ggthemes)

# load in the data we want to explore
df <- read_csv("ElginUOF.csv")

# store summary data in a dataframe 
dfsum <- data.frame(unclass(summary(df)), check.names = FALSE, stringsAsFactors = FALSE)
dfsum

# Sort the data by the Year_Quarter and create a sort column

df <-df[order(df$Year_Quarter),]
df$sort <- seq.int(nrow(df)) 

# Grab just the year and put in year column as number
df$year <- as.numeric(as.character( substr(df$Year_Quarter, start=1, stop=4) ))
# Grab just the quarter and put in quarter column
df$quarter <- substr(df$Year_Quarter, start=6, stop=7)

# update dfsum
dfsum <- data.frame(unclass(summary(df)), check.names = FALSE, stringsAsFactors = FALSE)

# Sum instances of UOF and store in new column
df$force <- df$UOF_only + df$Total_transitions

# create the new dataset
dfLook <- subset(df, select = c("year","Year_Quarter","force","Total_officer","Total_suspect"))

# Add major injuries columns and save
dfLook$Officer_major <- df$Officer_mayor
dfLook$Suspect_major <- df$Suspect_major

write_csv(dfLook,"dfLook.csv")

summary(dfLook)

# Looking at force vs. Officer data

# total_officer histogram and density
qplot(Total_officer,
      data=dfLook,
      fill=factor(year),
      bins = 12
)

qplot(Total_officer, data=dfLook, 
      geom="density",
      fill=factor(year),
      color=factor(year),
      linetype = factor(year),
      alpha=I(.5)
)

# incidents of force histogram and density
qplot(force,
      data=dfLook,
      fill=factor(year),
      bins = 12
)

qplot(force, data=dfLook, 
      geom="density",
      fill=factor(year),
      color=factor(year),
      linetype = factor(year),
      alpha=I(.5)
)

# scatter plot - force v. officer injures
qplot(force,Total_officer,
      data=dfLook, 
      xlab="UOF incidents", 
      ylab="officer injuried") + 
  stat_smooth(method="lm")

# look at significance
fit_officer <- lm(force ~ Total_officer, data = dfLook)
summary(fit_officer)

# scatter plot - force v. officer injures
# divided by major injuries
qplot(force,Total_officer,
      data=dfLook) + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(Officer_major))

# facet by year
qplot(force,Total_officer,
      data=dfLook) + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(year))

# both major injuries and year as factors

qplot(force,Total_officer,
      data=dfLook, 
      xlab="UOF incidents", 
      ylab="officer injuried") + 
  stat_smooth(method="lm") +
  facet_grid(factor(Officer_major) ~ factor(year))

# Create the plot

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

#-----------------
# create the plot

officer <- ggplot(dfLook) +
  aes(x=force, 
      y=Total_officer
  ) + 
  geom_point(stat="identity", 
             size = 3,
             shape=21,
             #alpha=I(.5),
             aes(
               color=factor(year),
               fill=factor(year) )
  ) +
  geom_smooth(method=lm,se=FALSE) +
  theme_gfx() +
  scale_y_continuous(limits = c(0, 10), breaks=c(seq(0,10,2)) ) #+
  #scale_x_continuous(limits = c(0, 44), breaks=c(seq(0,44,2)) )

# add all the titles.
officer <- officer + 
  labs(
    title="Headline",
    subtitle="Intro",
    x="USE OF FORCE INCIDENTS",
    y="INJURIES TO OFFICERS",
    caption="\nSource: Elgin police")


# color scheme - comment out for B/W PDF
officer <- officer + scale_colour_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") ) + scale_fill_manual( values = c("#0063A5", "#DE731D", "#009964", "#DA2128", "#6F2C91") )
# make B/W PDF - remember to change name of file!
#officer <- officer + scale_colour_grey(start = 0, end = 0.75) + scale_fill_grey(start = 0, end = 0.75)

officer

# -----
# Try looking at use of force and injuries to suspects