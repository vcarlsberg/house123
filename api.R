library(plumber)

# plumber.R

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  list(msg = paste0("The message is: '", msg, "'"))
}

pr("api.R") %>%
  pr_run(port=8000)
