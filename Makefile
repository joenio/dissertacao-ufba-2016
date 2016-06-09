# DOCUMENT VARIABLES

NAME= dissertacao qualificacao
CLEAN_FILES+= *.sigla* *symbols* imagens/*~ *.nav *.snm cache/*

# PROJECT VARIABLES

GZCAT= zcat
USE_PDFLATEX= true # directly generate .pdf files from the .tex
VIEWPDF= evince

include /usr/share/latex-mk/latex.gmk

rebuild:
	make clean
	make

watch:
	inotify-hookable --watch-files qualificacao.{tex,Rtex,R} --watch-files dissertacao.tex --on-modify-command make rebuild

knitr:
	cd dataset; ./analyze-all-projects; cd ..
	Rscript qualificacao.R

qualificacao.tex: knitr
	@echo "running knitr"

viewpdf_dissertacao:
	@echo "done"

viewpdf_qualificacao:
	@echo "done"
