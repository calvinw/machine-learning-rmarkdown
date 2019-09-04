r = getOption("repos") 
r["CRAN"] = "http://cran.r-project.org"
options(repos = r)
rm(r)
install.packages("RCurl")
install.packages('rvest')

