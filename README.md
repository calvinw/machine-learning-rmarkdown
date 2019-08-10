machine learning Rmds for Ma322

Each Rmd file can be rendered to the following formats: 
1. html
1. pdf 
1. md 
1. ipynb 
1. docx

The ipynb files can be uploaded to google colab once they are created. 
They are created by a command line tool called jupytext. 

Jupytext allows converting from rmarkdown or (regular) markdown to ipynb formats.

Jupyter must be installed as well since it is used to create the R kernel version of the ipynb formats.   

To see what the project depends on look at the .gitlab-ci.yml file since that is a recipe to install pre-reqs for this project.

Install jupyter and jupytext as follows:
>pip3 install jupyter  (or  sudo -H install jupyter to install systemwide)
>pip3 install jupytext (or  sudo -H install jupytext for systemwide)

Then from the command line build it this way: 
>make 

or from Rstudio choose the "Build All" menu from the Build tab

If you would like to make it so that you can automatically upload the ipynb and docx files to google docs you will have to create a credentials.json file from the googles developer console, and then use that together with google-app.js, which is a node application to upload the ipynb and docx files to google docs. 

I recommend taking a look at this example from google:
[Google Drive API Quickstart](https://developers.google.com/drive/api/v3/quickstart/nodejs)

This is basically the example we started with to create our google-app.js. You will need to create a credentials.json like they do in that example. Then put that in this repository for the google-apps.js app to read to get permission to access your google versions of the colab notebooks.
