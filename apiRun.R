library(plumber)
# 'plumber.R' is the location of the file shown above
r <- plumb("apiFunction.R")  # Where 'plumber.R' is the location of the file shown above
r$run(port=8000)
