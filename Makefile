# DOCUMENT VARIABLES

NAME= dissertacao apendices
CLEAN_FILES+= *.sigla* *symbols* imagens/*~ *.nav *.snm cache/* *.ist *.bcf *.run.xml

# PROJECT VARIABLES

GZCAT= zcat
USE_PDFLATEX= true # directly generate .pdf files from the .tex
VIEWPDF= @true

include /usr/share/latex-mk/latex.gmk

rebuild: clean cache documents appendix all

metrics:
	./bin/run-analizo dataset/software

filter:
	./bin/filter-papers "dataset/papers/ASE Papers/" > dataset/papers/filter-papers-ase.md
	./bin/filter-papers "dataset/papers/SCAM Papers/" > dataset/papers/filter-papers-scam.md

projects=$(wildcard dataset/software/*)
templates=$(wildcard templates/*.epl)

cache: cache/dataset.yml cache/references.bib
documents: documents/references.bib documents/*.csv documents/*.md documents/software-table.tex documents/*.tex
	$(info rendering templates...)
	@$(foreach t,$(templates),./bin/render $(t) > documents/$(basename $(notdir $(t)));)

appendices=$(wildcard templates/appendix/*.epl)
appendix: documents/appendix/*.tex
	$(info rendering appendix templates...)
	@$(foreach t,$(appendices),./bin/render $(t) > documents/appendix/$(basename $(notdir $(t)));)

cache/dataset.yml:
	@mkdir -p cache
	./bin/cache dataset/software/ > cache/dataset.yml

cache/references.bib:
	./bin/merge dataset/software/*/paper.bib dataset/software/*/search/*.bib > cache/references.bib

documents/references.bib: cache/dataset.yml cache/references.bib
	./bin/ids documents/references.bib cache/references.bib

references.yml: documents/references.bib
	$(info creating references.yml file for each software...)
	@$(foreach p,$(projects),./bin/render templates/software/references.yml.epl --software=$(notdir $(p)) > $(p)/references.yml;)

papers-download: dataset/papers/references
	cd dataset/papers
	git clone git@gitlab.com:joenio/papers.git .
