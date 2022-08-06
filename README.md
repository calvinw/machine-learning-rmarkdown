This project includes utilities and content for an introductory machine learning course taught using R. 

The examples are at the pages link for this project:  

[https://calvinw.gitlab.io/machine-learning-rmarkdown/)](https://calvinw.gitlab.io/machine-learning-rmarkdown/)

The primary format for all content is Rmarkdown (Rmd) files. 

Each Rmd file can be rendered by quarto to the following formats if desired: 

1. html
1. ipynb (Colab or Jupyter)

The html is built by using:

```bash
quarto render file.Rmd --to html 
```

The ipynb is built using this:

```bash
quarto render file.Rmd --to ipynb 
```

We currently mirror this repo to a [github repo](https://github.com/calvinw/machine-learning-rmarkdown) since Colab is slightly better at opening ipynb files stored in github repos (instead of gitlab).

To see what the project depends on look at the .gitlab-ci.yml file since that is a recipe to install pre-reqs for this project. Roughly the relevant things to install are as follows:

```bash
apt-get update
apt-get -y install libcurl4-openssl-dev libxml2-dev libssl-dev
wget "https://github.com/quarto-dev/quarto-cli/releases/download/v1.0.38/quarto-1.0.38-linux-amd64.deb"
dpkg -i quarto-1.0.38-linux-amd64.deb
Rscript -e "install.packages('knitr')"
Rscript -e "install.packages('rmarkdown')"
Rscript -e "install.packages('rvest')"
Rscript -e "install.packages('RCurl')"
Rscript -e "install.packages('rpart')"
Rscript -e "install.packages('rpart.plot')"
Rscript -e "install.packages('readr')"
Rscript -e "install.packages('Metrics')"
make
```

Then from the command line build it this way:

```bash
make 
```

You can also use 

```bash
make html 
```

to just make the html versions.

Or 

```bash
make ipynb 
```

to make the jupyter notebook versions
