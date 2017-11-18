# DOCUMENT VARIABLES

NAME= dissertacao
CLEAN_FILES+= *.sigla* *symbols* imagens/*~ *.nav *.snm cache/* *.ist *.bcf *.run.xml

# PROJECT VARIABLES

GZCAT= zcat
USE_PDFLATEX= true # directly generate .pdf files from the .tex
VIEWPDF= @true

include /usr/share/latex-mk/latex.gmk

rebuild: clean summary documents all

analyze:
	./bin/analyze-softwares -o dataset/metrics.csv

cache:
	@mkdir -p cache

summary: cache
	./bin/summarize-dataset dataset/software/ > cache/dataset.yml

filter:
	./bin/filter-papers "dataset/papers/ASE Papers/" > dataset/papers/filter-papers-ase.md
	./bin/filter-papers "dataset/papers/SCAM Papers/" > dataset/papers/filter-papers-scam.md

references: cache
	./bin/query dataset/software/*/paper.bib dataset/software/*/search/*.bib > cache/references.bib
	./bin/ids cache/references.bib > documents/references.bib

templates=$(wildcard templates/*.epl)
documents: $(templates) summary
	@$(foreach t,$(templates),./bin/render-template $(t) > documents/$(basename $(notdir $(t)));)
