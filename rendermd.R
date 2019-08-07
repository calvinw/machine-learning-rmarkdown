#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
if(length(args) != 2) {
    stop("Must pass Rmd and md filenames");
}

library(knitr)
library(rmarkdown)
rmdFile<-args[1]
mdFile<-args[2]
opts_chunk$set(results="hide", fig.show="hide", message=FALSE, warning=FALSE)
knit(rmdFile, output=mdFile)
lines <- readLines(mdFile);
partitions<-rmarkdown:::partition_yaml_front_matter(lines)
con <- file(mdFile);
writeLines(partitions$body, con)
close(con)
