library("knitr")

files <- list.files(pattern = "\\.Rmd$")
files<-grep(files, pattern="index", inv=T,value=T)
problems<-gsub(files, pattern=".Rmd$", replacement="")

mylines<-c("# Html Pages \n",
           "\n")
mylines2<-c("## colab notebooks\n")
mylines3<-c("## Rmarkdown \n")

lines<-c(" Notebooks ")

for(problem in problems) { 

    part0 <- problem
    part1<-paste0("[html]", "(", problem, ".html)")
    part2<-paste0("[colab]", "(https://colab.research.google.com/github/calvinw/machine-learning-rmarkdown/blob/master/", problem, ".ipynb)") 
    part3<-paste0("[Rmd]", "(", problem, ".Rmd)")

    lines<-c(lines, part0, part1, part2, part3, "\n") 

    # mylines<-c(mylines, part1)
    # mylines2<-c(mylines2, part2)
    # mylines3<-c(mylines3, part3)
}

# mylines<- c(mylines, "\n", mylines2, "\n", mylines3)
# fileConn<-file("index.Rmd")
# writeLines(mylines, fileConn)
fileConn<-file("index.Rmd")
writeLines(lines, fileConn)
close(fileConn)
