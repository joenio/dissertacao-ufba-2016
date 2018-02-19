Dissertação para obtenção do título de mestre no Programa de Pós-graduação em
Ciência da Computação ([PGCOMP](http://pgcomp.dcc.ufba.br)) da Universidade
Federal da Bahia ([UFBA](http://www.ufba.br)).

* Autor: [Joenio Marques da Costa](http://lattes.cnpq.br/6773346025855005)
* Orientadora: [Christina von Flach G. Chavez](http://lattes.cnpq.br/1827829018668226)
* Co-orientador: [Paulo Roberto Miranda Meirelles](http://lattes.cnpq.br/2193972715230641)

Agenda:

| Aividade     | Data                      | Slides                                               |
| ------------ | ------------------------- | ---------------------------------------------------- |
| Qualificação | 12 de Julho de 2016       | http://joenio.me/caracterizacao-analise-estatica     |
| Defesa       | 19 de Dezembro de 2017    | http://joenio.me/sustentabilidade-software-academico |

Banca examinadora:

* Titular interno: [Rodrigo Rocha Gomes e Souza](http://lattes.cnpq.br/7697794806460975)
* Titular externo: [Sandro Santos Andrade](http://lattes.cnpq.br/0177714301545658)
* Suplente interno: [Ivan do Carmo Machado](http://lattes.cnpq.br/4430958315746203)
* Suplente externo: [Igor Fabio Steinmacher](http://lattes.cnpq.br/5529725593221391)

Notícia sobre a defesa no site do PGCOMP:
* http://wiki.dcc.ufba.br/PGComp/Noticia20171222140028

Mais detalhes em:
* http://wiki.dcc.ufba.br/Aside/Orientacao2014JoenioCosta

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

    apt-get install libmodern-perl-perl sloccount libdevel-checkbin-perl

É necessário ter também o `analizo` e o `doxyparse`, siga as instruções de
instalação em:

* http://www.analizo.org/installation.html

Tenha o cuidado de instalar a versão `1.19.1` do Analizo corretamente:

    apt-get install doxyparse=1.8.11 analizo=1.19.1

Para executar use o make:

    make metrics

Os arquivos em `dataset/software/<nome>/releases/*.metrics` contém os resultados
da execução deste script, ele contém as métricas coletadas pelo Analizo para
cada software analisado.

## Script para filtro semi-automatizado da revisão de literatura

O script `bin/filter-papers` depende do comando `pdftotext`.

    apt-get install poppler-utils

Para executar o script basta rodar o seguinte comando:

    make filter

Irá gerar como saída um arquivo chamado `dataset/papers.txt`.

## Script para reportar os dados dos softwares acadêmicos coletados

Os scripts `bin/cache`, `bin/merge` e `bin/render` possuem as seguintes dependencias:

    apt-get install libtext-bibtex-perl libmojolicious-perl libyaml-perl \
                    libyaml-libyaml-perl libdatetime-format-http-perl

Use o make:

    make documents

Os resultados do comando acima são gravados em arquivos no diretório
`documents/*.{csv,dot,tex,yml}`.

## Referências sobre estatística

### Vídeo: FGV / IBRE – Estatística com R: 16 Quantis e Percentis

* https://www.youtube.com/watch?v=pZN-RmV4M6E

### Vídeo: Regressão Linear Simples - Ajuste de Reta

* https://www.youtube.com/watch?v=e5dKAK4Df04

### Vídeo: Regressão Linear Múltipla - Introdução

* https://www.youtube.com/watch?v=TLlzToeIpGc

## Contato

joenio EM joenio.me
