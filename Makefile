# DOCUMENT VARIABLES

NAME= dissertacao qualificacao
CLEAN_FILES+= *.sigla* *symbols* imagens/*~ *.nav *.snm cache/* figure/* *.Rtex

# PROJECT VARIABLES

GZCAT= zcat
USE_PDFLATEX= true # directly generate .pdf files from the .tex
VIEWPDF= evince

include /usr/share/latex-mk/latex.gmk

watch:
	inotify-hookable --watch-files qualificacao.Rtex qualificacao.R --watch-files dissertacao.tex --on-modify-command make

knitr:
	#cd dataset; ./analyze-all-projects; cd ..
	latexpand qualificacao.tex > qualificacao.Rtex
	Rscript qualificacao.R

qualificacao.tex: knitr
	@echo "running knitr"

viewpdf_dissertacao:
	@echo "done"

viewpdf_qualificacao:
	@echo "done"
