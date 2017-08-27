# check libraries
library(readr)
library(rgdal)
library(dplyr)
library(ggplot2)
library(ggmap)
library(ggthemes)

# Loading shapefiles

ill <- readOGR(dsn = "ILcounties/ILcounties.shp")

# divides things into slots geodata in one, data in another etc
# Access it with @, not $
head(ill@data, n = 10)
summary(ill@data)

# check the projection
ill@proj4string

plot(ill)

census16 <- read.csv("census2016_all.csv", stringsAsFactors = FALSE)
head(census16)
summary(census16)


# let's see if we can join by county name
ill$NAMELSAD10 %in% census16$Place


# Now join
ill@data <- left_join(ill@data, census16, by = c('NAMELSAD10' = 'Place'))
head(ill@data)
summary(ill@data)
names(ill)

# let's write the data to a csv and read it back again
write_csv(ill@data,"illdata.csv")
census16 <- read.csv("illdata.csv", stringsAsFactors = FALSE)
head(census16)
# let's get rid of a few columns we don't need
census16$STATEFP10=NULL
census16$COUNTYFP10=NULL
census16$COUNTYNS10=NULL
head(census16)
# now we have the census data with the geoid attached to each county
# working with ggplot means the data has to be saved in a different way. 
ill_f <- fortify(ill, region="GEOID10")

# let's look at the dataframe
head(ill_f, n = 5) 
# Fortify looks like it takes each polygon in a shapefile
# and changes it to a groupable set of points
# groupable based on ID
# Once we have this dataframe, we have to rejoin the 
# data associated with it.

ill_f$id <- as.numeric(as.character(ill_f$id))
class(ill_f$id)
class(census16$GEOID10)

ill_f <- left_join(ill_f, census16, by = c('id' = 'GEOID10'))

head(ill_f, n=5)

names(ill_f)
summary(ill_f$rate_16under19)
quantile(ill_f$rate_16under19, probs = seq(0, 1, .25))
# let's write the data to a csv
write_csv(ill_f,"ill_f.csv")
