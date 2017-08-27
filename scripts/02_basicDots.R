# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
df <- read_csv("dfCrime.csv")

summary(df)

# simple dot plot
dotchart(df$Total_RTR,labels=df$Year_Quarter,
         main="RTR incidents by year, quarter",
         xlab="RTR incidents")

# Assign colors to new column "color" based on year
df$color[df$year==2014] <- "red" 
df$color[df$year==2015] <- "blue" 
df$color[df$year==2016] <- "darkgreen"

# plot
dotchart(df$Total_RTR,labels=df$Year_Quarter,cex=.9,
         main="RTR incidents\ngrouped by year",
         xlab="RTR incidents", 
         color=df$color)
