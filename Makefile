# DOCUMENT VARIABLES

NAME= dissertacao
CLEAN_FILES+= *.sigla* *symbols* imagens/*~ *.nav *.snm cache/* figure/* _*.Rtex *.ist

# PROJECT VARIABLES

GZCAT= zcat
USE_PDFLATEX= true # directly generate .pdf files from the .tex
VIEWPDF= @true

include /usr/share/latex-mk/latex.gmk

analyze:
	./bin/analyze-softwares -o dataset/metrics.csv

filter:
	./bin/filter-papers -o dataset/papers.txt

render-templates:
	./bin/softwares-data -t capitulos/softwares-data-summary.tex.epl -o capitulos/softwares-data-summary.tex
	./bin/softwares-data -t capitulos/softwares-data-analysis.tex.epl -o capitulos/softwares-data-analysis.tex
