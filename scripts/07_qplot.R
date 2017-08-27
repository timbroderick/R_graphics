# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
library(ggplot2)
library(ggthemes)

df <- read_csv("dfCrime.csv")

summary(df)


#--------
# histogram

qplot(Total_RTR,
      data=df,
      fill=factor(year),
      bins = 12
)

# density plot
qplot(Total_RTR, data=df, 
      geom="density",
      fill=factor(year),
      color=factor(year),
      linetype = factor(year),
      alpha=I(.5), # I() keeps alpha out of legend
      main="Distribution of RTR incidents", 
      xlab="Total RTR incidents",
      ylab="Density")


# simple scatter with trend line
qplot(Total_RTR,UOF_only,
      data=df
) + geom_smooth(method = "lm")

# simple scatter, years as factor
# se hides 95% conf
qplot(Total_RTR,UOF_only,
      data=df,
      color=factor(year)
) + geom_smooth(method = "lm", se = FALSE) 


# scatter with facet grid
qplot(Total_RTR,UOF_only,
      data=df, 
      color=factor(year),
      xlab="Total RTR", ylab="UOF") + 
  facet_grid(. ~ factor(year))  + 
  geom_smooth(method = "lm", se = FALSE)

# scatter with two facets
qplot(Total_RTR,UOF_only,
      data=df, 
      color=factor(year),
      xlab="Total RTR", ylab="UOF") + 
  facet_grid(quarter ~ factor(year)) 

# here's the box plot
qplot(factor(year), SOF_only, 
      data=df, 
      geom=c("boxplot", "jitter"),
      fill=factor(year), 
      alpha=I(.5),
      main="SOF by Year",
      xlab="Year", ylab="SOF")

#a dot plot
qplot(factor(Year_Quarter), SOF_only, 
      data=df, 
      geom=c("dotplot"),
      fill=factor(year), 
      stackdir = "center", binaxis = "y",
      main="SOF by Year, quarter",
      xlab="Year", ylab="SOF")  + coord_flip()
