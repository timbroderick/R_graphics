# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
library(tidyr)

df <- read_csv("dfCrime.csv")

head(df)

# sort based on Year_Quarter and save rownumbers in new column
dfsort <-df[order(df$Year_Quarter),]
dfsort$sort <- seq.int(nrow(dfsort)) 
head(dfsort)

# Use tidyr to reshape dataframe
dfsub <- gather(dfsort, set, value, 7:9, factor_key=TRUE)

# make levels in "set" more readable for labeling purposes
# Can also use this to set an order to the levels
dfsub$set <- factor(dfsub$set, levels = c("Transitions","SOF_only","UOF_only"),
                 labels = c("Transitions","Show of force","Use of force" ))

# save to csv
write_csv(dfsub,"dfsubset.csv")