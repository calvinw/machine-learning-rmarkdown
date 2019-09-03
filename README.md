This project includes different rmarkdown machine learning documents 

The examples are shown at the pages link for this project:  

[Machine Learning Rmarkdown](https://calvinw.gitlab.io/machine-learning-rmarkdown/)

Each Rmd file can be rendered to each of the following formats if desired: 
1. html
1. pdf 
1. md
1. ipynb 
1. docx

The ipynb files can be uploaded and opened in [Google Colab](https://colab.research.google.com/) once they are created. Each one specifies the correct kernel (R) for Colab to use.  

These ipynb files are created by pandoc [pandoc]().  

pandoc can convert from markdown (md) to ipynb formats.

We use `rmarkdown::render` in our Makefile to render the html, pdf, md and docx versions of our files, then `pandoc` renders from md to ipynb.

The R kernel of Jupyter is used in the R versions of the ipynb Colab formats. This kernel choice works in Google Colab, though it is not advertised yet.   

To see what the project depends on look at the .gitlab-ci.yml file since that is a recipe to install pre-reqs for this project. Roughly the relevant things to install are as follows:

We just show installing these from the command line. If you are in RStudio you can use the Terminal window there. 

Here roughly is what is needed:

```bash
apt-get -y install libcurl4-openssl-dev libxml2-dev libssl-dev
wget "https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-1-amd64.deb"
dpkg -i pandoc-2.7.3-1-amd64.deb
wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh
Rscript -e "install.packages('rmarkdown')"
Rscript -e "install.packages('rvest')"
Rscript -e "install.packages('RCurl')"
Rscript -e "install.packages('C50')"
Rscript -e "install.packages('rpart')"
```

Then from the command line build it this way:

```bash
make 
```

or you can use Rstudio and choose the "Build All" menu from the Build tab. Likely if you just choose "Build All" in RStudio it will complain and make you install all the pre-reqs above as you go along. This is fine, just enter the above in RStudios Terminal window as you go along.

The above should be enough to get the files built. If you would like to investigate uploading the files to Google Colab or Google Drive, or if you would like to run the nodejs server we have in this repo, you have to install nodejs and npm. We don't cover installing these, just google them if you need to). You will then have to run: 

```bash
npm install
```

which uses the package.json file in this directory.

We use a node app called google-upload.js to upload the built .ipynb to Google Colab (really just Google Drive) 

If you would like to make it so that you can automatically upload the ipynb files to your Google Drive you will have to create a credentials.json file and place it in this directory. Go to the googles developer console, and create one in a similar fashion to this document from google:  

[Google Drive API Quickstart](https://developers.google.com/drive/api/v3/quickstart/nodejs)

This is basically the example we began with that became our google-upload.js. You will need to create a credentials.json like they do in that example. When you run google-upload.js it will upload to your versions of the Google Colab notebooks in your google drive.

Before you run the google-upload.js, you should create a Google Colab file for each Rmd you create You can "make a copy" of our google versions of these if you want, they should be viewable (but not editable) by the world [Machine Learning Rmarkdown folder](https://drive.google.com/open?id=1LduI2mOMabByvQRS2JPpMwttTeYyb9Og)

Then you use your own googleids from your copies and replace the ones in google-colab-ids.json

Note google-upload.js app does not create any Google Docs for you, just uploads and saves to existing ones after they are rendered by the make process. (Hopefully we will change this in the future so it creates colab files in a folder and its all more automated. 

Once you have your own versions of the google ids you want to use, you can upload the current built versions of the ipynb like this:

```bash
node google-upload.js Simple.ipynb
```

This reads the googleid for the Colab document for Simple from google-colab-ids.json and uploads the Simple.ipynb to that file in your google drive. 

When you run this you will ask you to authenticate the app and allow it to access your Google Drive. For this it uses the credentials.json you made above. It creates a token.json as you do this and that will be used on subsequent runs of the tool. This is the same process that the quickstart example from google above uses, so refer to that if you need more info on this process.. 

The files we use in google drive are at this link: 

[Machine Learning Rmarkdown folder](https://drive.google.com/open?id=1LduI2mOMabByvQRS2JPpMwttTeYyb9Og)

These should be viewable by everyone, so you can take a look.

See the Makefile for additional build details and targets.
