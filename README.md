Dissertação para obtenção do título de mestre no Programa de Pós-graduação em
Ciência da Computação ([PGCOMP](http://pgcomp.dcc.ufba.br)) da Universidade
Federal da Bahia ([UFBA](http://www.ufba.br)).

* Autor: Joenio Marques da Costa
* Orientadora: Christina von Flach G. Chavez
* Co-orientador: Paulo Roberto Miranda Meirelles

Mais detalhes em:
* http://wiki.dcc.ufba.br/Aside/Orientacao2014JoenioCosta

Slides:
* http://joenio.me/slides/caracterizacao-analise-estatica.html

## Compilando

Projeto escrito em latex para compilar é necessários ter um ambiente latex
básico e o projeto latex-mk, texlive-publishers, texlive-lang-portuguese.

    make

### Debian Testing

    sudo apt-get install r-recommended r-cran-knitr

### Debian Jessie

    sudo apt-get install r-recommended r-cran-evaluate r-cran-digest r-cran-stringr
    sudo R -e "install.packages('knitr', repos = 'http://www.rforge.net/', type = 'source', dependencies = TRUE)"

## Script para revisão estruturada semi-automatizada

O script `revisao-estruturada/filter` depende do comando `pdftotext`, em
sistemas Debian ele pode ser instalado com o seguinte comando:

    apt-get install poppler-utils

## Script para extrair e preparar dados com métricas dos projetos

    apt-get install libmodern-perl-perl sloccount

É necessário ter instalado também as ferramentas `analizo` e `doxyparse`.

    cd dataset
    ./analyze-all-projects

## Referências sobre estatística

### Vídeo: FGV / IBRE – Estatística com R: 16 Quantis e Percentis

* https://www.youtube.com/watch?v=pZN-RmV4M6E

### Vídeo: Regressão Linear Simples - Ajuste de Reta

* https://www.youtube.com/watch?v=e5dKAK4Df04

### Vídeo: Regressão Linear Múltipla - Introdução

* https://www.youtube.com/watch?v=TLlzToeIpGc

## Contato

joenio EM joenio.me
