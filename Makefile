# DOCUMENT VARIABLES

NAME= dissertacao
CLEAN_FILES+= *.sigla* *symbols* imagens/*~ *.nav *.snm cache/* figure/* _*.Rtex

# PROJECT VARIABLES

GZCAT= zcat
USE_PDFLATEX= true # directly generate .pdf files from the .tex
VIEWPDF= evince

include /usr/share/latex-mk/latex.gmk

knitr:
	cd dataset; ./analyze-all-projects; cd ..
	latexpand --keep-comments dissertacao.Rtex > _dissertacao.Rtex
	Rscript dissertacao.R
	mv _dissertacao.tex dissertacao.tex

#dissertacao.tex: knitr
#	@echo "running knitr"

viewpdf_dissertacao:
	@echo "done"
