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

references:
	./bin/query dataset/software/*/references/*.bib > cache/references.bib
	./bin/clean cache/references.bib > cache/_references.bib
	./bin/ids cache/_references.bib > documents/references.bib
	@rm cache/_references.bib cache/references.bib

templates=$(wildcard templates/*.epl)
documents: $(templates) summary
	@$(foreach t,$(templates),./bin/render-template cache/dataset.yml $(t) > documents/$(basename $(notdir $(t)));)

references=$(wildcard dataset/software/*)
merge: $(references)
	@$(foreach r,$(references),./bin/query $(r)/references/*.bib > $(r)/references.bib;)
