#!/bin/bash
echo "making json-data.js" 
node problems.js > json-data.js
echo "running node app.js" 
node app.js &
jupyter notebook --no-browser &
echo "Watching all *.Rmd files"
echo "and running make when they change" 
while true; do ls *.Rmd | entr make; done
