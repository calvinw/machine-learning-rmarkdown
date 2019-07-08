SOURCES=$(shell find . -name "*.Rmd")
HTML_FILES = $(SOURCES:%.Rmd=%.html)
PDF_FILES = $(SOURCES:%.Rmd=%.pdf)
IPYNB_FILES = $(SOURCES:%.Rmd=%.ipynb)
#DOCX_FILES = $(SOURCES:%.Rmd=%.docx)
export PATH := /bin:/usr/bin:/opt/R/3.4.4/lib/R/bin:$(PATH) 

all : $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES)
	@echo All files are now up to date

clean : 
	@echo Removing html files...	
	rm -f $(HTML_FILES) 
	@echo Removing pdf files...	
	rm -f $(PDF_FILES) 
	@echo Removing ipynb files...	
	rm -f $(IPYNB_FILES) 

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

%.ipynb : %.Rmd
	@echo Calling jupytext...	
	jupytext $< --to notebook --set-kernel ir
	@echo ipynb is rendered...	

server: 
	make -j watch node jupyter

watch:
	@echo Watching .Rmd files...	
	@echo Will call make on changes...	
	while true; do ls *.Rmd | entr make; done

jupyter: 
	@echo Launching Jupyter 
	jupyter notebook --no-browser 

node: 
	@echo Launching app.js 
	node app.js

.PHONY: all allpdf clean allFiles
