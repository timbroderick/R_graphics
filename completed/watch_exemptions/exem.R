library(readr)
df <- read_csv("homeExem.csv")

names(df)
summary(df)

# load in ggplot and themes
library(ggplot2)
library(ggthemes)


#dev.cur()
#pdf(file="ggplotBox.pdf", width = 7, height = 6.75) 
#png(filename = "ggplotBox.png",width = 600, height = 500, units = "px")
#-----Insert plot here -------------

boxgfx <- ggplot(df) + 
  aes(x = County, 
      y = ExemRate, 
      fill = factor(County)
      ) + 
  geom_boxplot() + 
  theme_fivethirtyeight() + geom_jitter()

# add all the titles.
boxgfx <- boxgfx + labs(
  title="Accepted exemptions", # your headline
  subtitle="Some assessors are more diligent about\ntracking the validity of homestead exemptions\nthat can reduce a home's assessed value\nby $6,000 to $7,000.",
  x="County", 
  y="PERCENT WITH\nHOMESTEAD EXEMPTIONS",
  caption="\n* For brevity, includes two townships in Will County.\nSource: County assessment offices")

boxgfx <- boxgfx + 
  theme(legend.position="None")


# Here's where we adapt the theme we're using to work for us
# Can ignore
boxgfx <- boxgfx + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 20),
  legend.text=element_text(size=16),
  axis.title=element_text(size=16, face="bold"),
  axis.text=element_text(size=14),
  plot.caption=element_text(size=14, hjust=0)
)

boxgfx

#----- End plot --------------
# Uncomment the line below when saving pdfs or pngs
#dev.off() 

