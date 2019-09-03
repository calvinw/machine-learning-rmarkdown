#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
if(length(args) != 1) {
    stop("renderRmdToMd: Expected Rmd filename");
}

library(knitr)
library(rmarkdown)

rmdFile<-args[1]

opts_knit[["set"]](progress = FALSE); 
opts_chunk[["set"]](results="hide", fig.show="hide", message=FALSE, warning=FALSE); 

md_document<-md_document(variant="markdown-fenced_code_attributes")
render(rmdFile, md_document)
