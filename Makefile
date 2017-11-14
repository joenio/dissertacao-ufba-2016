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

summary:
	@mkdir -p cache
	./bin/summarize-dataset dataset/software/ > cache/dataset.yml

filter:
	./bin/filter-papers "dataset/papers/ASE Papers/" > dataset/papers/filter-papers-ase.md
	./bin/filter-papers "dataset/papers/SCAM Papers/" > dataset/papers/filter-papers-scam.md

screening:
	./bin/query dataset/software/*/references.bib really_refers_to_software=yes > cache/_screening.bib
	./bin/clean cache/_screening.bib > cache/screening.bib
	./bin/ids cache/screening.bib > dataset/screening.bib

templates=$(wildcard templates/*.epl)
documents: $(templates) summary
	@$(foreach t,$(templates),./bin/render-template cache/dataset.yml $(t) > documents/$(basename $(notdir $(t)));)

references=$(wildcard dataset/software/*)
merge: $(references)
	@$(foreach r,$(references),./bin/merge $(r)/references/*.bib > $(r)/references.bib;)
