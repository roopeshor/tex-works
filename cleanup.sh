#! /usr/bin/bash

 find . -name "*.aux" -delete
 find . -name "*.auxlock" -delete
 find . -name "*.fls" -delete
 find . -name "*.log" -delete
 find . -name "*.out" -delete
 find . -name "*.ps" -delete
 find . -name "*.maf" -delete
 find . -name "*.mtc" -delete
 find . -name "*.mtc0" -delete
 find . -name "*.toc" -delete
 find . -name "*.lof" -delete
 find . -name "*.lot" -delete
 find . -name "*.synctex.gz" -delete
 find . -name "*.fdb_latexmk" -delete
 find . -name "*.xdv" -delete
 find . -name "*_minted*" -exec rm -r "{}" \;
 find . -name "*svg-inkscape" -delete
