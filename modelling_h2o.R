library(h2o)
library(tidyverse)

h2o.init()

modelling_data<-house123 %>% distinct(description, .keep_all= TRUE) %>% 
  filter(propertytype=="Rumah" & bedroom>0 & bathroom>0 & landarea>0 & buildingarea>0)

modelling_data$kab_kota<-as.factor(modelling_data$kab_kota)
modelling_data$kecamatan<-as.factor(modelling_data$kecamatan)

h2o_input<-as.h2o(modelling_data)

aml <- h2o.deeplearning(x = c(3,4,5,9,10,11,12), y = 2,
                  training_frame = h2o_input,
                  seed = 72,standardize = TRUE,nfolds = 10)

#summary(aml)
#aml
#h2o.get_leaderboard(aml)
h2o.performance(aml)

df.predict<-as.h2o(data.frame(bedroom=3,bathroom=2,carport=1,
                              buildingarea=90,landarea=105,
                              kecamatan="Citraland",kab_kota="Surabaya"))
#as.numeric(predict(linear.model, df.predict))

h2o.predict(aml, newdata = h2o_input)

