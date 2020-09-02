#Loading the rvest package
library(rvest)
library(plumber)
library(dplyr)

#initialize dataframe
house123<-data.frame(
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



for (page in 1:100)
{
  print(paste0("Processing page - ",page))
  
  #Specifying the url for desired website to be scraped
  url <- paste0('https://www.rumah123.com/jual/residensial/?subChannel=subsale&page=',page)
  
  #Reading the HTML code from the website
  webpage <- read_html(url)
  
  tryCatch(
    {
      for (a in 1:24)
      {
        #read link per row, and store on variable
        xp<-paste('//html//body//div[1]//div//div//div//div[2]//div[3]//div[1]//div//ul//li[',a,']//div[3]//div[1]//div[1]//div[1]//h3//a',sep = "")
        
        #save link on href variable
        href<-webpage %>% 
          html_nodes(xpath = xp) %>% 
          html_attr('href')
        
        
        #If length is not zero, then open link on href
        if (length(href)>0)
        {
          #open link to get detail specification of listing
          listing_link<-paste("https://www.rumah123.com",href,sep = "")
          print(listing_link)
          webpage2<-read_html(listing_link)
          
          #read price. Price information is located on xp_price
          xp_price<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/div[1]/span"
          price<-webpage2 %>% 
            html_nodes(xpath = xp_price) %>%
            html_text()
          price<-strsplit(price, " ")[[1]][2]
          price<-as.numeric(gsub("\\.","",price))
          
          #read kecamatan
          xp_kecamatan<-"/html/body/div[1]/div/div/div/div[2]/div[1]/div/ol/li[4]/a/span"
          kecamatan<-webpage2 %>% html_nodes(xpath = xp_kecamatan) %>% html_text()
          
          #read kabupaten/kota
          xp_kab_kota<-"/html/body/div[1]/div/div/div/div[2]/div[1]/div/ol/li[3]/a/span"
          kab_kota<-webpage2 %>% html_nodes(xpath = xp_kab_kota) %>% html_text()
          
          #read building area
          xp_buildingarea<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/div[3]/ul[1]/li[1]"
          buildingarea<-html_text(webpage2 %>% html_nodes(xpath = xp_buildingarea))
          regexp <- "[[:digit:]]+" #initialize regex to extract only number
          buildingarea<-as.numeric(str_extract(buildingarea, regexp))
          
          #read land area
          xp_landarea<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/div[3]/ul[1]/li[2]"
          landarea<-html_text(webpage2 %>% html_nodes(xpath = xp_landarea))
          #extract only number
          regexp <- "[[:digit:]]+" #initialize regex to extract only number
          landarea<-as.numeric(str_extract(landarea, regexp))
          
          #read title description
          xp_titledescription<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[2]/div[1]/div/h2"
          titledescription<-html_text(webpage2 %>% html_nodes(xpath=xp_titledescription))
          
          #read description
          xp_description<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[2]/div[1]/div/div/div[1]/pre"
          description<-html_text(webpage2 %>% html_nodes(xpath=xp_description))
          
          #read ad id, by selecting certain div (as described on html_nodes), then extract 10 last character
          ad_id<-webpage2 %>% 
            html_nodes("div.property-attr-listingId.ListingAttributesstyle__AttributeItemContainer-fiaKlH.iCRKVs") %>%
            html_text()
          ad_id<-str_sub(ad_id,start = -10)
          
          #read property type, split text based on colon (:) position, and extract 2nd part
          propertytype<-webpage2 %>% 
            html_nodes("div.property-attr-propertyType.ListingAttributesstyle__AttributeItemContainer-fiaKlH.iCRKVs") %>%
            html_text()
          propertytype<-strsplit(propertytype, ":")[[1]][2]
          
          #read certificate
          #xp_certificate<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[2]/div[2]/div/div/div[2]/div[1]/div[1]/div[1]/div/div[3]/div[2]"
          #certificate<-html_text(webpage2 %>% html_nodes(xpath=xp_certificate))
          
          #read number of bedroom. If no information on number of bathroom, replace with NA
          xp_bedroom<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/ul/li[1]"
          bedroom<-as.numeric(html_text(webpage2 %>% html_nodes(xpath=xp_bedroom)))
          if(is_empty(bedroom))
          {
            bedroom<-NA
          }
          
          #read number of bathroom
          xp_bathroom<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/ul/li[2]"
          bathroom<-as.numeric(html_text(webpage2 %>% html_nodes(xpath=xp_bathroom)))
          if(is_empty(bathroom))
          {
            bathroom<-NA
          }
          
          #read number of carport
          xp_carport<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/ul/li[3]"
          carport<-as.numeric(html_text(webpage2 %>% html_nodes(xpath=xp_carport)))
          if(is_empty(carport))
          {
            carport<-NA
          }
          
        }
        
        house123<-house123 %>% add_row(ad_id=ad_id, propertytype=propertytype,
                                       price=price, bedroom=bedroom, carport=carport,
                                       bathroom=bathroom, description=description,
                                       titledescription=titledescription,landarea=landarea,buildingarea=buildingarea,
                                       kab_kota=kab_kota,kecamatan=kecamatan)
        
        
      }
    },
    error=function(err){
      print("error reading... skipping to next listing")
    }
    
  )
  

}



