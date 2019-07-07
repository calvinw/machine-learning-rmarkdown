SOURCES=$(shell find . -name "*.Rmd")
HTML_FILES = $(SOURCES:%.Rmd=%.html)
PDF_FILES = $(SOURCES:%.Rmd=%.pdf)
#DOCX_FILES = $(SOURCES:%.Rmd=%.docx)
export PATH := /bin:/usr/bin:/opt/R/3.4.4/lib/R/bin:$(PATH) 

all : $(HTML_FILES) $(PDF_FILES)
	@echo All files are now up to date

clean : 
	@echo Removing html files...	
	rm -f $(HTML_FILES) 
	@echo Removing pdf files...	
	rm -f $(PDF_FILES) 

allFiles:
	find -name '*.Rmd' | sort > allFiles 

%.html : %.Rmd
	@echo Calling render for html...	
	Rscript -e 'rmarkdown::render("$<", "html_document")'
	@echo html render is finished...	
	-echo $@ | nc -q .01 localhost 4000

%.pdf : %.Rmd
	@echo Calling render for pdf...	
	Rscript -e 'rmarkdown::render("$<", "pdf_document")'
	@echo pdf render is finished...	

.PHONY: all allpdf clean allFiles
