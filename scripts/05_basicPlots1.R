# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
df <- read_csv("dfCrime.csv")

summary(df)

# Now lets see this as a scatter plot
with(df, plot(Total_RTR, UOF_only))
title(main = "UOF vs Total RTR incidents")

# Add median lines
abline(h=median(df$UOF_only), lty=2, lwd=2) 
abline(v=median(df$Total_RTR), lwd=2, col="red") 

# compute the regression or fit line and add to chart
fit <- lm(df$UOF_only~df$Total_RTR)
abline(fit)

# take a look at the fit stats
summary(fit)

# Seeing all three RTR categories

# set up the plot area so that there's three plots
par(mfrow=c(3,1),mar=c(4,4,2,1))

# Let's add the plot we already did
with(df, plot(Total_RTR, UOF_only,
              xlim=c(0, 60), ylim=c(0, 35)))
title(main = "UOF vs Total RTR incidents")
abline(h=median(df$UOF_only), lty=2, lwd=2) 
abline(v=median(df$Total_RTR), lwd=2, col="red") 
abline(lm(df$UOF_only~df$Total_RTR))

# now SOF 
with(df, plot(Total_RTR, SOF_only,
              xlim=c(0, 60), ylim=c(0, 35)))
title(main = "SOF vs Total RTR incidents")
abline(h=median(df$SOF_only), lty=2, lwd=2) 
abline(v=median(df$Total_RTR), lwd=2, col="red") 
abline(lm(df$SOF_only~df$Total_RTR))

# finally, transitions
with(df, plot(Total_RTR, Transitions,
              xlim=c(0, 60), ylim=c(0, 35))) 
title(main = "Transitions vs Total RTR incidents")
abline(h=median(df$Transitions), lty=2, lwd=2) 
abline(v=median(df$Total_RTR), lwd=2, col="red") 
abline(lm(df$Transitions~df$Total_RTR))

