#Loading the rvest package
library('rvest')

#Specifying the url for desired website to be scraped
url <- 'https://www.rumah123.com/jual/residensial/?subChannel=subsale&page=2'

#Reading the HTML code from the website
webpage <- read_html(url)

for (a in 1:24)
{
  xp<-paste('//html//body//div[1]//div//div//div//div[2]//div[3]//div[1]//div//ul//li[',a,']//div[3]//div[1]//div[1]//div[1]//h3//a',sep = "")
  print(webpage %>% 
    html_nodes(xpath = xp) %>% 
    html_attr('href'))
}

/html/body/div[1]/div/div/div/div[2]/div[3]/div[1]/div/ul/li[1]/div/div[1]/div[3]/div[1]/div[1]/div[1]/h3/a
  
webpage2<-read_html(paste("https://www.rumah123.com",prop_link,sep = ""))
price<-webpage2 %>%
  html_nodes(xpath='//*[@id="app"]/div/div/div[2]/div[2]/div[2]/div[1]/div[1]/div[2]/div[1]/span')

html_text(price)

webpage %>% 
  html_nodes(xpath = '//*[@id="app"]/div/div/div[2]/div[3]/div[1]/div/ul/li[2]/div/div[1]/div[3]/div[1]/div[1]/div[1]/h3')

