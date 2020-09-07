library(h2o)

h2o.init()

modelling_data<-house123 %>% distinct(description, .keep_all= TRUE) %>% 
  filter(propertytype=="Rumah" & bedroom>0 & bathroom>0)

h2o_input<-as.h2o(modelling_data)

aml <- h2o.automl(x = c(3,4,5,9,10), y = 2,
                  training_frame = h2o_input,
                  seed = 72,sort_metric = "RMSE"
)
