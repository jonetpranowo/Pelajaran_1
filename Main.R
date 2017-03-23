#Read data
dat <- read.csv("ArrestMini.csv")
dat<-na.omit(dat)
names(dat)

#Make new variables "DATE" dan "TIME" from variable "ARRESTTIME"
library(tidyr)
library(dplyr)
dat1 <- dat %>% 
  separate(ARRESTTIME, c('DATE', 'TIME'), sep = 'T')

#Aggregate by case

Arrest_Daily <- dat1 %>%
  group_by(DATE) %>%
  summarize(CASES = n(), NUM_COUNCIL = n_distinct(COUNCIL_DISTRICT)) %>%
  arrange(DATE)

View(Arrest_Daily)

#Plot

rdate <- as.Date(Arrest_Daily$DATE, "%Y-%m-%d")
plot(Arrest_Daily$NUM_COUNCIL~rdate, type="l", col="red", xlab="Time",ylab="Numb of Council Districts Having Crime", main="The Spread of Crime", lwd=1)
