# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
df <- read_csv("dfCrime.csv")

summary(df)

# create basic plot
plot(df$Total_RTR, df$UOF_only, 
     xlim=c(0, 60), ylim=c(0, 35),
     main = "UOF vs Total RTR incidents", 
     xlab="Total response to resistance incidents", 
     ylab="Use of force incidents only")

# Select data out of total for each year
y2014 <- subset(df, year==2014)
y2015 <- subset(df, year==2015)
y2016 <- subset(df, year==2016)
# Add those to plot
points(y2014$Total_RTR,y2014$UOF_only,col="red",pch=19)
points(y2015$Total_RTR,y2015$UOF_only,col="blue",pch=19)
points(y2016$Total_RTR,y2016$UOF_only,col="green",pch=19)

# Add a legend
legend("topleft", 
       pch = c(19,19,19), 
       col = c("red","blue","green"), 
       legend = c("2014", "2015", "2016"))

# Add the regression line
abline(lm(df$UOF_only~df$Total_RTR))

#--------------
# Plot all three categories, using color
# clear the plot window
dev.off()

# generate the first plot
plot(df$Total_RTR, df$UOF_only, 
     main = "Response to resistance incidents", 
     xlab="Total response to resistance incidents", 
     ylab="Response by type",
     xlim=c(0,60), ylim=c(0,35),
     col=adjustcolor("red", alpha=0.4),
     pch=19)
# Add the other two sets of points
points(df$Total_RTR,df$SOF_only,
       col=adjustcolor("blue", alpha=0.4),
       pch=19)
points(df$Total_RTR,df$Transitions,
       col=adjustcolor("green", alpha=0.4),
       pch=19)
# add the legend
legend("topleft", 
       pch = c(19,19,19), 
       col = c("red","blue","green"), 
       legend = c("UOF", "SOF", "Transitions"))
# Add the regression lines, but color them (par) to match
abline(lm(df$UOF_only~df$Total_RTR, par(col="red")))
abline(lm(df$SOF_only~df$Total_RTR, par(col="blue")))
abline(lm(df$Transitions~df$Total_RTR, par(col="green")))

