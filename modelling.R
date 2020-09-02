library(car)
library(dplyr)

modelling_data<-house123 %>% distinct(description, .keep_all= TRUE)


linear.model<-lm(price~0+bedroom+bathroom+carport+buildingarea+landarea,data = modelling_data)
summary(linear.model)

vif(linear.model)
