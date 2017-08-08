Dissertação para obtenção do título de mestre no Programa de Pós-graduação em
Ciência da Computação ([PGCOMP](http://pgcomp.dcc.ufba.br)) da Universidade
Federal da Bahia ([UFBA](http://www.ufba.br)).

* Autor: Joenio Marques da Costa
* Orientadora: Christina von Flach G. Chavez
* Co-orientador: Paulo Roberto Miranda Meirelles

Agenda:

| Aividade     | Data                                          |
| ------------ | --------------------------------------------- |
| Qualificação | 12 de Julho de 2016                           |
| Defesa       | _proposta: primeira semana de fevereiro/2017_ |

Mais detalhes em:
* http://wiki.dcc.ufba.br/Aside/Orientacao2014JoenioCosta

Slides:
* http://joenio.me/slides/caracterizacao-analise-estatica.html

(todas as instruções abaixo consideram que você está rodando o sistema
operacional Debian GNU/Linux testing/stretch)

## Compilando

Projeto escrito em LaTeX para compilar é necessários ter um ambiente latex
básico e algumas extensões.

    apt-get install texlive-publishers texlive-lang-portuguese latex-mk

Após instalar todas as dependências basta executar `make` na raiz do projeto.

    make

## Script para análise e coleta de métricas de código-fonte

O script para extração e análise dos dados utilizados neste estudo, localizado
em `bin/analize-softwares` possui as seguintes dependencias:

    apt-get install libmodern-perl-perl sloccount

É necessário ter também o `analizo` e o `doxyparse`, siga as instruções de
instalação em:

* http://www.analizo.org/installation.html

Para executar use o make:

    make analyze

O arquivo `dataset/metrics.csv` contém o resultado da execução deste
script, ele contém as métricas coletadas pelo Analizo para cada software
analisado.

## Script para revisão estruturada semi-automatizada

O script `bin/filter-papers` depende do comando `pdftotext`.

    apt-get install poppler-utils

Para executar o script basta rodar o seguinte comando:

    make filter

Irá gerar como saída um arquivo chamado `dataset/papers.txt`.

## Script para reportar os dados dos softwares acadêmicos coletados

O script `bin/softwares-summary` possui as seguintes dependencias:

    apt-get install libtext-bibtex-perl libmojolicious-perl libyaml-perl

Use o make:

    make softwares-summary

O resultado do comando acima é gravado no arquivo
`capitulos/softwares-summary.tex`.

## Referências sobre estatística

### Vídeo: FGV / IBRE – Estatística com R: 16 Quantis e Percentis

* https://www.youtube.com/watch?v=pZN-RmV4M6E

### Vídeo: Regressão Linear Simples - Ajuste de Reta

* https://www.youtube.com/watch?v=e5dKAK4Df04

### Vídeo: Regressão Linear Múltipla - Introdução

* https://www.youtube.com/watch?v=TLlzToeIpGc

## Agradecimentos

* Rodrigo Rocha
* Daniela Feitosa
* Paulo Meirelles
* Christina von Flach
* Ivan Machado
* Claudio Sant'ana
* Marcos Ronaldo
* Fabiana Goa
* Lucas Kanashiro
* Antonio Terceiro
* Crescêncio Lima
* Mariel Zasso
* Hilmer Neri
* Talita Gentil

## Créditos

### Imagens e ícones

* https://openclipart.org/detail/237990/pdf
* https://openclipart.org/detail/65635/software-carton-box-with-no-text-remix

## Contato

joenio EM joenio.me
