# plumber.R

#* Get calculation of house
#* @param bedroom How many bedroom available?
#* @param bathroom How many bathroom available?
#* @param landarea What's the size of landarea?
#* @param buildingarea Size of building area?
#* @post /houseprice
function (bedroom,bathroom,landarea,buildingarea){
  df.predict<-data.frame(bedroom=as.numeric(bedroom),
                         bathroom=as.numeric(bathroom),
                         landarea=as.numeric(landarea),
                         buildingarea=as.numeric(buildingarea))
  as.numeric(predict(linear.model, df.predict))
}


#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
  as.numeric(a) + as.numeric(b)
}

