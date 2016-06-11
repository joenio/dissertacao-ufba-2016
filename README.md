# Caracterização da qualidade interna de ferramentas de análise estática de código fonte

Dissertação para obtenção do título de mestre no Programa de Pós-graduação em
Ciência da Computação ([PGCOMP](http://pgcomp.dcc.ufba.br)) da Universidade
Federal da Bahia ([UFBA](http://www.ufba.br)).

* Autor: Joenio Marques da Costa
* Orientadora: Christina von Flach G. Chavez
* Co-orientador: Paulo Roberto Miranda Meirelles

Mais detalhes em:
* http://wiki.dcc.ufba.br/Aside/Orientacao2014JoenioCosta

# TODO

* [OK] Entender o termo caracterização utilizado pelo grupo Chris

Outra possibilidade de trabalho futuro envolve tentar identificar associação entre a
métrica utilizada para complexidade estrutural e outros atributos de qualidade de soft-
ware, em especial atributos de qualidade externa, como defeitos, usabilidade, etc. Di-
versos outros atributos de qualidade interna e externa já são utilizados com preditores
de defeitos, mas não se tem notı́cia da complexidade estrutural ser utilizada para esta
finalidade.

* [OK] Fazer uma tabela com os percentis das métricas (ver tese de Paulo)

H1 - É possível identificar padrões e tendências na evolução da arquitetura do sis-
tema Android e nos aplicativos desenvolvidos para ele.


* Ver análise feita no TCC de Ronaldo para replicar como analisou os percentis

Assim como feito por Meirelles (2013), os resultados das análises discutidos no
Capítulo 3 serão em função dos percentis 75, 90 e 95, correspondendo a valores muito
frequentes, frequentes e pouco frequentes, respectivamente.

* Analisar de perto se as ferramentas selecionadas sao mesmo de analise estatica
* Fechar as hipóteses
* Criar capítulo sobre Analizo e minhas contribuiçoes
* ...
* Feedback de paulo sobre os dados:
  * CBO claramente tem um comportamento diferente das demais, geralmente
    o crescimento é exponencial ou calda longa, mas CBO não tem mostrado
    este comportamento, as vezes é calda loga inertida
  * Nao preciso plotar os dados de todas as métricas por projeto
  * Na qualificação posso mostrar todas as métricas e na discussão
    irei selecionar algumas (possivelmente CBO, LCOM4 e SC)
  * Fácil notar só olhando a tabela que no percentil 75% (muito frequente)
    os valores estão bons, bons significa próximo dos valores teóricos ideais
  * Os valores dos percentis 90% e acima são pontos fora da curva, n podemos
    usar estes valores como alerta para indicar que o projeto está ruim
  * O crescimento reflete o mesmo comportamento dos estudos de paulo e
    kanashiro

## Questão

Quais características das ferramentas de análise estática de código fonte podem
ser obtidas a partir da avaliação da sua qualidade interna?

## GQM

Nivel conceitual:

* Vamos caracterizar ferramentas de analise estatica de codigo fonte
* Com respeito a sua qualidade interna
* Do ponto de vista do engenheiro de software
* No contexto de softwares academicos e industriais

## Compilando

Projeto escrito em latex para compilar é necessários ter um ambiente latex
básico e o projeto latex-mk texlive-publishers texlive-lang-portuguese.

    make

Monitora alterações nos arquivos do projeto e recompila PDF automaticamente,
depende to pacote inotify-hookable.

    make watch


### Debian Testing

    sudo apt-get install r-recommended r-cran-knitr

### Debian Jessie

    sudo apt-get install r-recommended r-cran-evaluate r-cran-digest r-cran-stringr
    sudo R -e "install.packages('knitr', repos = 'http://www.rforge.net/', type = 'source', dependencies = TRUE)"

## Script para revisão estruturada semi-automatizada

O script depende do comando `pdftotext`, em sistemas Debian ele pode ser
instalado com o seguinte comando:

    # apt-get install poppler-utils

## Script para extrair e preparar dados com métricas dos projetos

    apt-get install libmodern-perl-perl

precisa também do analizo, doxyparse, sloccount

    cd dataset
    ./analyze-all-projects

## Referências sobre estatística

### Vídeo: FGV / IBRE – Estatística com R: 16 Quantis e Percentis 

* https://www.youtube.com/watch?v=pZN-RmV4M6E

## Contato

joenio EM joenio.me
