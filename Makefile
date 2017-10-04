# DOCUMENT VARIABLES

NAME= dissertacao
CLEAN_FILES+= *.sigla* *symbols* imagens/*~ *.nav *.snm cache/* figure/* _*.Rtex *.ist imagens/softwares-charts/*.png capitulos/softwares-data-*.tex

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
	./bin/summarize-dataset dataset/academic-softwares/ > cache/dataset.yml

filter:
	./bin/filter-papers -o dataset/papers.txt

render-templates: summary
	./bin/render-template -i dataset/academic-softwares.yml -t templates/softwares-data-summary.tex.epl -o capitulos/softwares-data-summary.tex
	./bin/render-template -i dataset/academic-softwares.yml -t templates/softwares-data-table.tex.epl -o capitulos/softwares-data-table.tex
	#./bin/render-template -i dataset/academic-softwares.yml -t templates/softwares-data-table.csv.epl -o dataset/softwares-data-table.csv

charts:
	./bin/chart-softwares-data -i dataset/academic-softwares.yml -o imagens/softwares-charts/

citations=$(wildcard dataset/academic-softwares/*)
merge-bibtex: $(citations)
	@$(foreach citation,$(citations),./bin/merge-bibtex $(citation)/citations/*.bib > $(citation)/citations.bib;)
