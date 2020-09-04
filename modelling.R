library(car)
library(MASS)
library(caret)
library(fastDummies)
library(tidyverse)

modelling_data<-house123 %>% distinct(description, .keep_all= TRUE) %>% 
  filter(propertytype=="Rumah" & bedroom>0 & bathroom>0)

#house123.tibble<-as_tibble(house123)

#modelling_data<-dummy_columns(modelling_data,select_columns="kab_kota",
#                              remove_first_dummy = TRUE)

#modelling_data<-modelling_data %>% dplyr::select(!c(ad_id,description,titledescription,propertytype,kecamatan,kab_kota))

linear.model<-lm(price~bedroom+buildingarea+landarea+bathroom,data = modelling_data)
summary(linear.model)

vif(linear.model)

#df.predict<-data.frame(bedroom=3,bathroom=2,carport=0,buildingarea=90,landarea=105)
#as.numeric(predict(linear.model, df.predict))



#stepwise.model <- stepAIC(linear.model, direction = "both", trace = TRUE)
#summary(stepwise.model)

#train.control <- trainControl(method = "cv", number = 10)
#step.model <- train(price~bedroom+bathroom+buildingarea+landarea,data = modelling_data,
#                    method = "leapBackward", 
#                    trControl = train.control
#)
#step.model$results
