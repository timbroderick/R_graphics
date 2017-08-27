# The code in this file is described 
# in the pdf and html files of the same name

# Load the readr library
library(readr)

# load in the data
elgCrime <- read_csv("ElginUOF.csv")

# Here's a number of ways to take a look at what we've loaded
ls() # lists the data sets loaded
class(elgCrime) # see's what the data is
dim(elgCrime) # finds dimensions in rows and columns
nrow(elgCrime) # finds number of rows
ncol(elgCrime) # finds number of columns
object.size(elgCrime) # size of the data set in memory used
names(elgCrime) # returns vector of column names
head(elgCrime) # looks at first six columns (with column names)
tail(elgCrime) # looks at the last six columns (with column names)
head(elgCrime, 10) # looks at first 10 rows
tail(elgCrime, 5) # looks at athe last 5 rows

# get summary of the data
summary(elgCrime)
# save that in a dataframe
sumElg <- do.call(cbind, lapply(elgCrime, summary))

# ---------------
# sort by year/quarter column in ascending order
elgCrime[order(elgCrime$Year_Quarter),]

# Grab just the year and put in year column as number
elgCrime$year <- as.numeric(as.character( substr(elgCrime$Year_Quarter, start=1, stop=4) ))
# Grab just the quarter and put in quarter column
elgCrime$quarter <- substr(elgCrime$Year_Quarter, start=6, stop=7)

# check the columns
names(elgCrime)

# grab only columns we want and store them in a new dataframe
dfCrime <- elgCrime[,c("Year_Quarter","year","quarter","Total_CFS","Total_arrests","Total_RTR_incidents","SOF_only","UOF_only","Total_transitions")]

# Rename some columns
names(dfCrime)[names(dfCrime)=="Total_RTR_incidents"] <- "Total_RTR"
names(dfCrime)[names(dfCrime)=="Total_transitions"] <- "Transitions"

# save that dataframe into a csv file
write_csv(elgCrime,"dfCrime.csv")


# ------------------
# Visualize the data

# Generate a histogram
hist(dfCrime$Total_RTR, breaks=10, main="Histogram", col="green")

# look at Density
d <- density(dfCrime$Total_RTR) 
d
plot(d, main="Total RTR incidents") # plots the results
polygon(d, col=rgb(1, 0, 0,0.5), border="red") 

# Look at density by year using sm library
library(sm)

# find how many years there are
listF <- as.factor(dfCrime$year)
listF

# make the plot
sm.density.compare(dfCrime$Total_RTR, 
                   dfCrime$year, 
                   xlab="Total RTR incidents", 
                   ylim= c(0,0.08))
title(main="Response to Resistance by year")

# Add a legend
RTRyears <- factor(dfCrime$year, 
                   levels= c("2014","2015","2016"), 
                   labels = c("2014", "2015", "2016")
                   )
colfill<-c( 2:( 2+length( levels(RTRyears) ) ) )
legend( "topright", 
        levels(RTRyears), 
        fill=colfill )
