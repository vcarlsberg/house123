library(Rcrawler)
library(rvest)

Rcrawler(Website ="https://www.rumah123.com/en/sale/all-residential/?subChannel=subsale")

Rcrawler(Website ="https://www.rumah123.com/properti/",dataUrlfilter = "/(hos|aps)[0-9]{7}",
         saveOnDisk = FALSE)

Rcrawler(Website = "http://www.glofile.com/", dataUrlfilter = "/[0-9]{4}/[0-9]{2}/",
         ExtractXpathPat = c("//*/article","//*/h1"), PatternsNames = c("content","title"))

Rcrawler(Website = "https://bitcointalk.org/", ManyPerPattern = TRUE,
         ExtractCSSPat = c("head>title","div[class=\"post\"]"),
         no_cores = 4, no_conn =4, PatternsName = c("Title","Replays"))

