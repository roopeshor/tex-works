# Tex Works

Sort of backup & reference folder for my tex works.

> To compile these, its recommended to install entire texlive packages (`texlive-full`)
## Compile to pdf

 `lualatex -shell-escape -8bit file.tex`
 
## Clean up whole directory
`./cleanup.sh`

## Clean up tmp files
`latexmk -C`