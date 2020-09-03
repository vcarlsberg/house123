library(pls)

modelling_data<-house123 %>% distinct(description, .keep_all= TRUE) %>% 
  filter(propertytype=="Rumah")

set.seed(2)
pcr.model<- pcr(price~bedroom+buildingarea+landarea+bathroom, 
                data = modelling_data, validation = "CV",ncomp=2)
summary(pcr.model)


validationplot(pcr.model, val.type = "MSEP")

df.predict<-data.frame(bedroom=3,bathroom=2,carport=0,buildingarea=90,landarea=105)
as.numeric(predict(pcr.model, df.predict))
