#Loading the rvest package
library(rvest)
library(dplyr)

#initialize dataframe
house<-data.frame(
  ad_id=character(),
  price=integer(),
  bedroom=integer(),
  bathroom=integer(),
  carport=integer(),
  description=character(),
  titledescription=character(),
  propertytype=character(),
  buildingarea=integer(),
  landarea=integer(),
  kecamatan=character(),
  kab_kota=character()
  
  
)

for (page in 1:1000)
{
  url <- paste0('https://www.rumah.com/properti-dijual/',page,'?property_type=B&property_type_code%5B0%5D=BUNG')
  
  webpage <- read_html(url)
  
  for (listing in 1:20)
  {
    link_to_detail
    
  }
}


/html/body/div[1]/div/div/section[1]/div[2]/div/div[2]/div[2]/section/div[2]/div[1]/div[1]/div[2]/div[1]/div/h3/a
/html/body/div[1]/div/div/section[1]/div[2]/div/div[2]/div[2]/section/div[2]/div[2]/div[1]/div[2]/div[1]/div/h3/a
/html/body/div[1]/div/div/section[1]/div[2]/div/div[2]/div[2]/section/div[2]/div[3]/div[1]/div[2]/div[1]/div/h3/a
/html/body/div[1]/div/div/section[1]/div[2]/div/div[2]/div[2]/section/div[2]/div[20]/div[1]/div[2]/div[1]/div/h3/a