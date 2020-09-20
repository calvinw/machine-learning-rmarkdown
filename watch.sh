#!/bin/bash
python -m SimpleHTTPServer 8000 &>/dev/null &
pid=$!
ls *.Rmd | entr make
kill "${pid}"
