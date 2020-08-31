#Loading the rvest package
library('rvest')
library(tidyr)
library(readr)
library(tidyverse)

#initialize dataframe
house123<-data.frame(
  ad_id=character(),
  propertytype=character(),
  price=character()
)

house123<-house123 %>% add_row(ad_id=ad_id, propertytype=propertytype,price=price)

#Specifying the url for desired website to be scraped
url <- 'https://www.rumah123.com/jual/residensial/?subChannel=subsale&page=1'

#Reading the HTML code from the website
webpage <- read_html(url)

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
    webpage2<-read_html(paste("https://www.rumah123.com",prop_link,sep = ""))
    
    #read price. Price information is located on xp_price
    xp_price<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/div[1]/span"
    price<-html_text(webpage2 %>% html_nodes(xpath = xp_price))
    
    #read location
    xp_location<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/div[2]/h1/span/span"
    location<-html_text(webpage2 %>% html_nodes(xpath = xp_location))
    
    #read building area
    xp_buildingarea<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/div[3]/ul[1]/li[1]"
    buildingarea<-html_text(webpage2 %>% html_nodes(xpath = xp_buildingarea))
    
    #read land area
    xp_landarea<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/div[3]/ul[1]/li[2]"
    landarea<-html_text(webpage2 %>% html_nodes(xpath = xp_landarea))
    
    #read title description
    xp_titledescription<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[2]/div[1]/div/h2"
    titledescription<-html_text(webpage2 %>% html_nodes(xpath=xp_titledescription))
    
    #read description
    xp_description<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[2]/div[1]/div/div/div[1]/pre"
    description<-html_text(webpage2 %>% html_nodes(xpath=xp_description))
    
    #read ad id
    xp_ad_id<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[2]/div[2]/div/div/div[2]/div[1]/div[1]/div[1]/div/div[1]/div[2]"
    ad_id<-html_text(webpage2 %>% html_nodes(xpath=xp_ad_id))
    
    #read property type
    xp_propertytype<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[2]/div[2]/div/div/div[2]/div[1]/div[1]/div[1]/div/div[2]/div[2]"
    propertytype<-html_text(webpage2 %>% html_nodes(xpath=xp_propertytype))
    
    #read certificate
    #xp_certificate<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[2]/div[2]/div/div/div[2]/div[1]/div[1]/div[1]/div/div[3]/div[2]"
    #certificate<-html_text(webpage2 %>% html_nodes(xpath=xp_certificate))
    
    #read number of bedroom
    xp_bedroom<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/ul/li[1]"
    bedrooom<-html_text(webpage2 %>% html_nodes(xpath=xp_bedroom))
    
    #read number of bathroom
    xp_bathroom<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/ul/li[2]"
    bathroom<-html_text(webpage2 %>% html_nodes(xpath=xp_bathroom))
    
    #read number of carport
    xp_carport<-"/html/body/div[1]/div/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/ul/li[3]"
    carport<-html_text(webpage2 %>% html_nodes(xpath=xp_carport))
  }
  
  
  
}

webpage2<-read_html(paste("https://www.rumah123.com",prop_link,sep = ""))
price<-webpage2 %>%
  html_nodes(xpath='//*[@id="app"]/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/div[1]/span')

html_text(price)

webpage %>% 
  html_nodes(xpath = '//*[@id="app"]/div/div/div[2]/div[3]/div[1]/div/ul/li[2]/div/div[1]/div[3]/div[1]/div[1]/div[1]/h3')

