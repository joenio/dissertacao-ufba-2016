# DOCUMENT VARIABLES

NAME= dissertacao qualificacao
CLEAN_FILES+= *.sigla* *symbols* imagens/*~ *.nav *.snm

# PROJECT VARIABLES

GZCAT= zcat
USE_PDFLATEX= true # directly generate .pdf files from the .tex
VIEWPDF= evince

include /usr/share/latex-mk/latex.gmk

watch:
	inotify-hookable --watch-files qualificacao.tex --watch-files dissertacao.tex --on-modify-command make

viewpdf_dissertacao:
	@echo "nao faz nada"

viewpdf_qualificacao:
	@echo "nao faz nada"
