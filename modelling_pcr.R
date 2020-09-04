library(pls)

modelling_data<-house123 %>% distinct(description, .keep_all= TRUE) %>% 
  filter(propertytype=="Rumah" & str_detect(kab_kota,"Jakarta") 
          & bedroom>0 & bathroom>0 & price>50000000)

set.seed(2)
pcr.model<- pcr(price~bedroom+buildingarea+landarea+bathroom+carport, 
                data = modelling_data, validation = "CV")
summary(pcr.model)

validationplot(pcr.model, val.type = "MSEP")

df.predict<-data.frame(bedroom=2,bathroom=2,carport=1,buildingarea=155,landarea=200)
as.numeric(predict(pcr.model, df.predict,ncomp = selectNcomp(pcr.model)))
