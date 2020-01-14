SHELL:=/bin/bash
SOURCES=$(shell find . -name "*.Rmd")

HTML_FILES = $(SOURCES:%.Rmd=%.html)
MD_FILES = $(SOURCES:%.Rmd=%.md)
IPYNB_FILES = $(SOURCES:%.Rmd=%.ipynb)
PDF_FILES = $(SOURCES:%.Rmd=%.pdf)

all : $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES) $(MD_FILES)
	@echo All files are now up to date

clean :
	@echo Removing html, md, pdf, files...	
	rm -f $(HTML_FILES) $(PDF_FILES) $(MD_FILES)
	rm -rf *_files 

%.html : %.Rmd
	@Rscript -e 'library(knitr); library(rmarkdown)' \
	         -e 'opts_chunk[["set"]](results="hold")' \
	         -e 'render("$<","html_document")'

%.pdf : %.Rmd
	@Rscript -e 'library(knitr); library(rmarkdown)' \
	         -e 'opts_chunk[["set"]](results="hold")' \
	         -e 'render("$<","pdf_document")'

%.md : %.Rmd
	@Rscript -e 'library(knitr); library(rmarkdown)' \
	    -e 'opts_chunk[["set"]](results="hide")' \
	    -e 'opts_chunk[["set"]](fig.show="hide")' \
	    -e 'opts_chunk[["set"]](message=FALSE)' \
	    -e 'opts_chunk[["set"]](warning=FALSE)' \
	    -e 'format<-md_document(variant="markdown-fenced_code_attributes")' \
	    -e 'render("$<",format)'
	@sed -i 's/``` r/``` code/g' $@
	@sed -i 's/``` python/``` code/g' $@

%.ipynb : %.md
	pandoc $< -o $@

.PHONY: all clean
