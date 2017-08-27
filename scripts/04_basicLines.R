# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
df <- read_csv("dfCrime.csv")

summary(df)

#---------
# plot total RTR

plot(df$Total_RTR, type="b",
     xlab = "Year, Quarter", 
     ylab = "Incidents",
     main = "Total RTR incidents")
?plot

# -----------------
# build line plot in steps

# find the x range
xrange <- range(1,NROW(df$Year_Quarter))
xrange

# find the y range (greatest number in any of three columns)
yrange <- range(0,df$SOF_only,df$UOF_only,df$Transitions)
yrange

# set up the plot with x and y range, 
# no chart type or axes
plot(xrange, yrange, type="n", axes=FALSE,
     xlab = "Year, Quarter", ylab = "Incidents",
     main = "Total RTR incidents")

# add the lines individually
lines(df$SOF_only, type = "b", pch=19, 
      col = "orange", lwd=2)
lines(df$UOF_only, type = "b", pch=17, 
      col = "blue", lwd=2)
lines(df$Transitions, type = "b", pch=15, 
      col = "darkgreen", lwd=2)
?pch

# now add the x axis
axis(1, las=1, at=1:xrange[2], tck = .05,
     lab=c("1Q\n2014","2Q\n","3Q\n","4Q\n","1Q\n2015","2Q\n","3Q\n","4Q\n","1Q\n2016","2Q\n","3Q\n","4Q\n") )

# add the y axis
axis(2, las=1, at=5*0:yrange[2], tck = 1, lty=3)

# Add the legend
legend(1, yrange[2], 
       c("SOF Only","UOF only", "Transition"), 
       cex=0.8, 
       col=c("Orange","blue","darkgreen"), 
       pch=c(19,17,15), lwd=2)

