#!/bin/bash
#python -m SimpleHTTPServer 8000 &>/dev/null &
Rscript -e "servr::httw(pattern='*.html')" &

pid=$!

trap ctrl_c EXIT 
function ctrl_c() {
    echo "Killing the servr::httw"
    kill "${pid}"
}

echo "calling ls *.Rmd | entr make"
ls *.Rmd | entr make html
