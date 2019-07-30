SOURCES=$(shell find . -name "*.Rmd")
#SOURCES= Elasticity.Rmd
HTML_FILES = $(SOURCES:%.Rmd=%.html)
#HTML_FILES =
PDF_FILES = $(SOURCES:%.Rmd=%.pdf)
#PDF_FILES =
IPYNB_FILES = $(SOURCES:%.Rmd=%.ipynb)
#IPYNB_FILES =
MD_FILES = $(SOURCES:%.Rmd=%.md)
#MD_FILES =
#DOCX_FILES = $(SOURCES:%.Rmd=%.docx)
DOCX_FILES =
#GOOGLE_UPLOAD = yes
#SERVER = yes

export PATH := /bin:/usr/bin:/opt/R/3.4.4/lib/R/bin:$(PATH) 

all : $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES) $(MD_FILES) $(DOCX_FILES)
	@echo All files are now up to date

clean : 
	@echo Removing html, md, pdf and ipynb files...	
	rm -f $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES) $(MD_FILES) $(DOCX_FILES)

allFiles:
	find -name '*.Rmd' | sort > allFiles 

%.html : %.Rmd
	@echo Calling render for html...	
	Rscript -e 'rmarkdown::render("$<", "html_document")'
	@echo html render is finished...	
ifdef SERVER
	@echo Send message to browser to reload html $@ ...
	-echo $@ | nc -q .01 localhost 4000
endif

%.md : %.Rmd
	@echo Calling render for md...
	Rscript rendermd.R $< $@
	@echo md render is finished...

%.pdf : %.Rmd
	@echo Calling render for pdf...	
	Rscript -e 'rmarkdown::render("$<", "pdf_document")'
	@echo pdf render is finished...	

%.ipynb : %.md
	@echo Calling jupytext...	
	jupytext $< --to notebook --set-kernel ir
	@echo ipynb is rendered...
ifdef GOOGLE_UPLOAD
	@echo uploading to google
	node google-app.js $@
endif

data: 
	node problems.js > data.json

server: 
	make -j watch nodeapp

watch:
	@echo Watching .Rmd files...	
	@echo Will call make on changes...	
	while true; do ls *.Rmd | entr make SERVER=yes; done

jupyter: 
	@echo Launching Jupyter 
	jupyter notebook --no-browser 

nodeapp: 
	@echo Launching app.js 
	node app.js

.PHONY: all allpdf clean allFiles
