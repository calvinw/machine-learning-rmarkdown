#!/bin/bash
python -m SimpleHTTPServer 8000 &>/dev/null &

pid=$!

trap ctrl_c EXIT 
function ctrl_c() {
    kill "${pid}"
}

ls *.Rmd | entr make
