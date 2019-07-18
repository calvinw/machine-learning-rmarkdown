SOURCES=$(shell find . -name "*.Rmd")
#HTML_FILES = $(SOURCES:%.Rmd=%.html)
HTML_FILES =
#PDF_FILES = $(SOURCES:%.Rmd=%.pdf)
PDF_FILES =
IPYNB_FILES = $(SOURCES:%.Rmd=%.ipynb)
#IPYNB_FILES =
#DOCX_FILES = $(SOURCES:%.Rmd=%.docx)
export PATH := /bin:/usr/bin:/opt/R/3.4.4/lib/R/bin:$(PATH) 

all : $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES)
	@echo All files are now up to date

clean : 
	@echo Removing html, pdf and ipynb files...	
	rm -f $(HTML_FILES) $(PDF_FILES) $(IPYNB_FILES) 

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
	@echo ipynb is rendered...uploading to google	
	node google-app.js $@ 1s1I1ujfB21_JDPecLl49STBxPAUznViZ

data: 
	node problems.js > json-data.js

server: 
	make -j watch nodeapp

watch:
	@echo Watching .Rmd files...	
	@echo Will call make on changes...	
	while true; do ls *.Rmd | entr make; done

jupyter: 
	@echo Launching Jupyter 
	jupyter notebook --no-browser 

nodeapp: 
	@echo Launching app.js 
	node app.js

.PHONY: all allpdf clean allFiles
