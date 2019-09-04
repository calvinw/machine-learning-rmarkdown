r = getOption("repos") 
r["CRAN"] = "https://cloud.r-project.org/"
options(repos = r)
rm(r)
install.packages("RCurl")
install.packages('rvest')

