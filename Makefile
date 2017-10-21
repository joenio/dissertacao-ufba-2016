# DOCUMENT VARIABLES

NAME= dissertacao
CLEAN_FILES+= *.sigla* *symbols* imagens/*~ *.nav *.snm cache/* *.ist *.bcf *.run.xml

# PROJECT VARIABLES

GZCAT= zcat
USE_PDFLATEX= true # directly generate .pdf files from the .tex
VIEWPDF= @true

include /usr/share/latex-mk/latex.gmk

rebuild: clean summary charts render-templates all

analyze:
	./bin/analyze-softwares -o dataset/metrics.csv

summary:
	@mkdir -p cache
	./bin/summarize-dataset dataset/software/ > cache/dataset.yml

filter:
	./bin/filter-papers "dataset/papers/ASE Papers/" > dataset/papers/filter-papers-ase.md
	./bin/filter-papers "dataset/papers/SCAM Papers/" > dataset/papers/filter-papers-scam.md

render-templates: summary
	./bin/render-template cache/dataset.yml templates/dataset-summary.tex.epl > result-documents/dataset-summary.tex
	./bin/render-template cache/dataset.yml templates/software-table.tex.epl > result-documents/software-table.tex
	./bin/render-template cache/dataset.yml templates/available-table.tex.epl > result-documents/available-table.tex
	./bin/render-template cache/dataset.yml templates/source-code-table.tex.epl > result-documents/source-code-table.tex
	./bin/render-template cache/dataset.yml templates/license-table.tex.epl > result-documents/license-table.tex
	./bin/render-template cache/dataset.yml templates/search-strings-table.tex.epl > result-documents/search-strings-table.tex

charts:
	./bin/chart-dataset -i cache/dataset.yml -o result-documents/charts/

citations=$(wildcard dataset/software/*)
merge-bibtex: $(citations)
	@$(foreach citation,$(citations),./bin/merge-bibtex $(citation)/citations/*.bib > $(citation)/citations.bib;)
