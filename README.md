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

* Feedback Chris/Paulo:
  * Falta descrever a questão e conectar com a hipótese
    * (trabalhos relacionados)
  * Deixar apenas 2 eventos + NIST
  * Discutir com maior foco SC (CBO/LCOM4) ... trabalho de terceiro
  * Na fund teorica cito arquitetura da ferramenta de analise estatica,
    irei discutir isto na metodologia/analise?
  * Pode ser que consiga fazer um link com arq e as caracteristicas
    e metricas
  * Revisitar e reformular questão de pesquisa e hipóteses
  * A caracterização da SC irá indicar que a qualidade n é ruim necessariamente
    mas que é uma caractaristica natural deste domínio, e isto irá guiar
    como proceder para evoluir e manter tais ferramentas
  * Tese de Paulo 4.1 e 4.3 (percentis, a média pode nos enganar)
  * A SC é mais alta neste domínio de aplicação (hipótese)
  * Ao menos objetivo geral, especifico, questao e hipoteses, contribuicoes, etc...
  * ... porque? para quem quiser manter/evoluir uma ferramenta de analise estatica
    entender que uma SC X ou Y para este dominio n eh ruim, mas é uma caracteristica natural
  * Para um sub-conjunto das ferramentas a arquitetura pode ser utilizada (...)
    (recuperar a arquitetura e dar subsidios para quem quer evoluir onde deve ser feito,
     exemplo, se quero adicinar suporte a nova linguagem onde irei mexer?)
  * Hipótese/discussao: parser com suporte multi-linguagem é mais complexo
  * Falar de análise estática na fundamentação
  * Mapeamento sistematico é uma contribuiçao, mas a revisão estruturada não é,
    a revisão estruturada irá compor a metodologia apenas, ...
    (será preciso fundamentar análise estática - no capítulo 2, dentro de qualidade
    interna fazer gancho com análise estática)

Questão: Como explicar a complexidade estrutural em ferramentas de código-fonte?

H1: Ferramentas de análise estátic tendem uma maior SC que outros domínios

H2: Ferramentas da indústria tender a ter uma menor SC que as ferraamentas cientificas

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
