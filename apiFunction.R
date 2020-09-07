# plumber.R

#* Get calculation of house
#* @param bedroom How many bedroom available?
#* @param bathroom How many bathroom available?
#* @param carport What's the size of carport? 1 cars, 2 cars?
#* @param landarea What's the size of landarea?
#* @param buildingarea Size of building area?
#* @post /houseprice
function (bedroom,bathroom,carport,landarea,buildingarea,res){
  if(missing(bedroom)|missing(bathroom)|missing(carport)|missing(landarea)|missing(buildingarea))
  {
    res$status<-400
  }else{
    res$status<-200
    df.predict<-data.frame(bedroom=as.numeric(bedroom),
                           bathroom=as.numeric(bathroom),
                           carport=as.numeric(carport),
                           landarea=as.numeric(landarea),
                           buildingarea=as.numeric(buildingarea))
    as.numeric(predict(pcr.model, df.predict,ncomp = selectNcomp(pcr.model)))    
  }


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
function(a, b,res,req) {
  if (missing(a)|missing(a))
  {
    res$status <- 404 # Unauthorized
    
    return(res)

#    list(error = "Feature x is missing.")
#    res$body <- jsonlite::toJSON(auto_unbox = TRUE, list(
#      status = 400,
#      message = "Missing required 'id' parameter."
#    ))
    
#    res$status<-400
#    return(res)
  }else{
    as.numeric(a) + as.numeric(b)  
  }
  
}


#' Generate a friendly error
#' @get /friendly
function(res){
  msg <- "Your request did not include a required parameter."
  res$status <- 400 # Bad request
  list(error=jsonlite::unbox(msg))
}
