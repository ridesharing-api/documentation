#!/usr/bin/env bash

rm output/*
pandoc --listings -H setup.tex --toc -V geometry:"left=1cm, top=1cm, right=1cm, bottom=2cm" -V fontsize=12pt --latex-engine=xelatex -s src/* -o output/documentation-`date +%Y-%m-%d`.pdf
