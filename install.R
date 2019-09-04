r = getOption("repos") 
r["CRAN"] = "https://cran.case.edu/"
options(repos = r)
rm(r)
install.packages("RCurl")
install.packages('rvest')

