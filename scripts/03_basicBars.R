# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
df <- read_csv("dfCrime.csv")

summary(df)

#-----------
# Basic bar plot

barplot(df$Total_RTR, 
        names.arg = df$Year_Quarter, cex.names=0.8,
        main="RTR incidents by year, quarter",
        xlab = "Number of incidents",
        col="blue")

# make the plot horizontal
barplot(df$Total_RTR, horiz=TRUE, 
        names.arg = df$Year_Quarter, cex.names=0.8,
        main="RTR incidents by year, quarter",
        xlab = "Number of incidents",
        col="blue")

# make the axis labels horizontal
par(las=1) 

barplot(df$Total_RTR, horiz=TRUE, 
        names.arg = df$Year_Quarter, cex.names=0.8,
        main="RTR incidents by year, quarter",
        xlab = "Number of incidents",
        col="blue")

# more info on basic plot parameters
?par

# -----------
# Stacked bar plot

# Load the data we want into a matrix
counts2 <- matrix(c(df$SOF_only,df$UOF_only,df$Transitions),ncol=3)
# name the columns
colnames(counts2)=c("SOF_only","UOF_only","Transitions")
# name the rows by the year/quarter
rownames(counts2)=df$Year_Quarter
counts2

# now, transpose it
counts <- t(counts2)
counts

#plot, with legend
par(las=1)

barplot(counts, horiz=TRUE, cex.names=0.8,
        main="RTR incidents by year, quarter",
        xlab = "Number of incidents",
        col=c("green","blue","red"),
        legend = rownames(counts),
        args.legend = list(x ='bottomright', inset=0.01)
)

# ------
# grouped bar plot
par(las=1)

barplot(counts, horiz=TRUE, cex.names=0.8,
        beside=TRUE,
        main="RTR incidents by year, quarter",
        xlab = "Number of incidents",
        col=c("green","blue","red"),
        legend = rownames(counts),
        args.legend = list(x ='bottomright', inset=0.01)
)
