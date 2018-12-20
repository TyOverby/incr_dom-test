#!/bin/bash
clear
python -m SimpleHTTPServer 9000 > /dev/null 2> /dev/null &
dune build --watch ./main.bc.js > errors.txt
