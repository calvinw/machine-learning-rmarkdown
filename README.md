This project includes utilities and content for an introductory machine learning course taught using R. 

The examples are at the pages link for this project:  

[https://calvinw.gitlab.io/machine-learning-rmarkdown/)](https://calvinw.gitlab.io/machine-learning-rmarkdown/)

The primary format for all content is Rmarkdown (Rmd) files. 

Each Rmd file can be rendered by a makefile to the following formats if desired: 

1. html
1. pdf 
1. ipynb (Colab or Jupyter)

R's rmarkdown and knitr packages are used to render the html, pdf and ipynb versions from the corresponding Rmd. The ipynb versions are created by using [pandoc](https://pandoc.org/) to convert from markdown (md) version to the ipynb. This is possible since recent versions of pandoc can create ipynb from markdown [see example](https://pandoc.org/try/?text=---%0Atitle%3A+%22Calculator%22%0Ajupyter%3A%0A++kernelspec%3A%0A++++display_name%3A+R%0A++++language%3A+R%0A++++name%3A+ir%0A---%0A%23+Lorem+ipsum%0A%0A**Lorem+ipsum**+dolor+sit+amet%2C+consectetur+adipiscing+elit.+Nunc+luctus%0Abibendum+felis+dictum+sodales.%0A%0A%60%60%60+code%0Aa%3C-3%0Ab%3C-4%0Aa%0Ab%0A%60%60%60%0A**Lorem+ipsum**+dolor+sit+amet%2C+consectetur+adipiscing+elit.+Nunc+luctus%0Abibendum+felis+dictum+sodales.%0A%0A%60%60%60+code%0Aplot(runif(20))%0A%60%60%60&from=markdown&to=ipynb).  

The ipynb versions are a format `ipynb_document` that is given in the "ipynb_document.R" file. So you should source this document before using it.

Once the ipynb files are committed to a Github repo they can then be opened in [Google Colab](https://colab.research.google.com/) or in [Binder](https://mybinder.org/).

We currently mirror this repo to a [github repo](https://github.com/calvinw/machine-learning-rmarkdown) since Colab and Binder are slightly better at opening ipynb files stored in github repos (instead of gitlab).

The R kernel of Jupyter is used in the R versions of the ipynb Colab formats. This kernel choice works in Google Colab, though it is not well advertised yet.   

To see what the project depends on look at the .gitlab-ci.yml file since that is a recipe to install pre-reqs for this project. Roughly the relevant things to install are as follows:

We just show installing these from the command line. If you are in RStudio you can use the Terminal window there. 

```bash
apt-get update
apt-get -y install libcurl4-openssl-dev libxml2-dev libssl-dev
apt-get -y install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
wget "https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-1-amd64.deb"
dpkg -i pandoc-2.7.3-1-amd64.deb
Rscript -e "install.packages('rmarkdown')"
Rscript -e "install.packages('rvest')"
Rscript -e "install.packages('RCurl')"
Rscript -e "install.packages('rpart')"
Rscript -e "install.packages('rpart.plot')"
Rscript -e "install.packages('readr')"
Rscript -e "install.packages('Metrics')"
```

Then from the command line build it this way:

```bash
make 
```

or you can use Rstudio and choose the "Build All" menu from the Build tab. Likely if you just choose "Build All" in RStudio it will complain and make you install all the pre-reqs above as you go along. This is fine, just enter the above in RStudios Terminal window as you go along.


See the Makefile for additional build details and targets.
