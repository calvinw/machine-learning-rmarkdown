SHELL:=/bin/bash
SOURCES:=$(wildcard *.Rmd)
SOURCES:=$(filter-out index.Rmd, $(SOURCES))

HTML_FILES = $(SOURCES:%.Rmd=%.html)
IPYNB_FILES = $(SOURCES:%.Rmd=%.ipynb)

all : html ipynb
	@echo All files are now up to date

clean :
	@echo Removing files...	
	rm -f $(HTML_FILES) $(IPYNB_FILES)
	rm -rf *_files

html   : $(HTML_FILES)

ipynb  : $(IPYNB_FILES)

%.html : %.Rmd
	quarto render $<  --to html

%.ipynb : %.Rmd
	quarto render $<  --to ipynb 

watch: 
	ls *.Rmd | entr make html

.PHONY: all clean
