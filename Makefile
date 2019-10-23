SHELL:=/bin/bash
SOURCES =$(shell find . -name "*.Rmd")
#SOURCES = Purchased.Rmd HotChoc.Rmd Restaurant.Rmd

HTML_FILES = $(SOURCES:%.Rmd=%.html)
MD_FILES = $(SOURCES:%.Rmd=%.md)
IPYNB_FILES = $(SOURCES:%.Rmd=%.ipynb)
PDF_FILES = $(SOURCES:%.Rmd=%.pdf)
DOCX_FILES = $(SOURCES:%.Rmd=%.docx)

export PATH :=.:/bin:/usr/bin:$(PATH)

all : $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES) $(MD_FILES) $(DOCX_FILES)
	@echo All files are now up to date

clean :
	@echo Removing html, md, pdf, docx files...	
	rm -f $(HTML_FILES) $(PDF_FILES) $(MD_FILES) $(DOCX_FILES)
	rm -rf *_files figure

%.html : %.Rmd
	@Rscript renderRmd.R $< html_document
ifdef SERVER
	@echo Send message to browser to reload html $@ ...
	-echo $@ | nc -q .01 localhost 4000
endif

%.md : %.Rmd
	@Rscript renderRmdToMd.R $<
	@sed -i 's/``` r/``` code/g' $@
	@sed -i 's/``` python/```code/g' $@

%.pdf : %.Rmd
	@Rscript renderRmd.R $< pdf_document

%.docx : %.Rmd
	@Rscript renderRmd.R $< word_document

%.ipynb : %.md
	pandoc $< -o $@

data: 
	node problems.js > data.json

server:
	make -j watch nodeapp

watch:
	@echo Watching .Rmd files...	
	@echo Will call make on changes...	
	while true; do ls *.Rmd | entr make -j1 SERVER=yes; done

nodeapp: 
	@echo Launching app.js 
	node app.js

.PHONY: all clean
