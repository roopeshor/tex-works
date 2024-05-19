#! /usr/bin/bash

rm **/**/*.aux \
 **/**/*.fls \
 **/**/*.log \
 **/**/*.out \
 **/**/*.ps \
 **/**/*.maf \
 **/**/*.mtc \
 **/**/*.mtc0 \
 **/**/*.synctex.gz \
 **/**/*.fdb_latexmk \
 */**/*.pdf \
 **/**/_minted-* \
 **/svg-inkscape -r
