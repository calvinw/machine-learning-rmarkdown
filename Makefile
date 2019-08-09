SOURCES=$(shell find . -name "*.Rmd")
HTML_FILES = $(SOURCES:%.Rmd=builds/%.html)
PDF_FILES = $(SOURCES:%.Rmd=builds/%.pdf)
IPYNB_FILES = $(SOURCES:%.Rmd=builds/%.ipynb)
MD_FILES = $(SOURCES:%.Rmd=builds/%.md)
DOCX_FILES = $(SOURCES:%.Rmd=builds/%.docx)
#HTML_FILES = builds/Python.html
# PDF_FILES = builds/Python.pdf
# IPYNB_FILES = builds/Python.ipynb
# MD_FILES = builds/Python.md
# DOCX_FILES = builds/Python.docx

export PATH :=.:/bin:/usr/bin:/opt/R/3.4.4/lib/R/bin:$(PATH)
export RETICULATE_PYTHON=/usr/bin/python3

all : $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES) $(MD_FILES) $(DOCX_FILES)
	@echo All files are now up to date

clean : 
	@echo Removing html, md, pdf, docx and ipynb files...	
	rm -f $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES) $(MD_FILES) $(DOCX_FILES)

builds/%.html : %.Rmd
	@echo Calling render for html...	
	Rscript -e 'rmarkdown::render("$<", output_dir="builds", "html_document")'
	@echo html render is finished...	
ifdef SERVER
	@echo Send message to browser to reload html $@ ...
	-echo $@ | nc -q .01 localhost 4000
endif

builds/%.md : %.Rmd
	@echo Calling render for md...
	Rscript rendermd.R $< $@
	@echo md render is finished...

builds/%.pdf : %.Rmd
	@echo Calling render for pdf...	
	Rscript -e 'rmarkdown::render("$<", output_dir="builds", "pdf_document")'
	@echo pdf render is finished...	

builds/%.docx : %.Rmd
	@echo Calling render for docx...	
	Rscript -e 'rmarkdown::render("$<", output_dir="builds", "word_document")'
	@echo docx render is finished...	

builds/%.ipynb : builds/%.md
	@echo Calling jupytext...	
	jupytext $< --to notebook
	@echo ipynb is rendered...

data: 
	node problems.js > data.json

server:
	make -j watch nodeapp

watch:
	@echo Watching .Rmd files...	
	@echo Will call make on changes...	
	while true; do ls *.Rmd | entr make -j1 SERVER=yes; done

googlecolab:
	@echo uploading ipynb files to google
	node google-app.js $(IPYNB_FILES)
	@echo done uploading to google

googledocx:
	@echo uploading docx files to google
	node google-app.js $(DOCX_FILES)
	@echo done uploading to google

jupyter: 
	@echo Launching Jupyter 
	jupyter notebook --no-browser 

nodeapp: 
	@echo Launching app.js 
	node app.js

.PHONY: all clean
