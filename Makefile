SHELL:=/bin/bash
SOURCES =$(shell find . -name "*.Rmd")

HTML_FILES = $(SOURCES:%.Rmd=%.html)
MD_FILES = $(SOURCES:%.Rmd=%.md)
IPYNB_FILES = $(SOURCES:%.Rmd=%.ipynb)
PDF_FILES = $(SOURCES:%.Rmd=%.pdf)
DOCX_FILES = $(SOURCES:%.Rmd=%.docx)

COLAB_UPLOADS =

export PATH :=.:/bin:/usr/bin:$(PATH)

all : $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES) $(MD_FILES) $(DOCX_FILES)
	@echo All files are now up to date

clean :
	@echo Removing html, md, pdf, docx and ipynb files...	
	rm -f $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES) $(MD_FILES) $(DOCX_FILES)

%.html : %.Rmd
	@echo Calling render for html..
	Rscript renderRmd.R $< html_document
	@echo html render is finished...
ifdef SERVER
	@echo Send message to browser to reload html $@ ...
	-echo $@ | nc -q .01 localhost 4000
endif

%.md : %.Rmd
	@echo Calling render for md...
	Rscript renderRmdToMd.R $<
	@sed -i 's/``` r/``` code/g' $@
	@sed -i 's/``` python/```python/g' $@
	@echo md render is finished...

%.pdf : %.Rmd
	@echo Calling render for pdf..
	Rscript renderRmd.R $< pdf_document
	@echo pdf render is finished...

%.docx : %.Rmd
	@echo Calling render for docx...	
	Rscript renderRmd.R $< word_document
	@echo docx render is finished...	

%.ipynb : %.md
	@echo Calling render for ipynb...	
	/usr/bin/pandoc $< -o $@
	@echo ipynb render is finished...
	$(if $(findstring $@, $(COLAB_UPLOADS)), node google-upload.js $@)

data: 
	node problems.js > data.json

server:
	make -j watch nodeapp

watch:
	@echo Watching .Rmd files...	
	@echo Will call make on changes...	
	while true; do ls *.Rmd | entr make -j1 SERVER=yes; done

colaball:
	@echo uploading ipynb files to google
	node google-upload.js $(IPYNB_FILES)
	@echo done uploading to google

nodeapp: 
	@echo Launching app.js 
	node app.js

.PHONY: all clean
