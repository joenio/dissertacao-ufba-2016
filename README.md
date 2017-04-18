Dissertação para obtenção do título de mestre no Programa de Pós-graduação em
Ciência da Computação ([PGCOMP](http://pgcomp.dcc.ufba.br)) da Universidade
Federal da Bahia ([UFBA](http://www.ufba.br)).

* Autor: Joenio Marques da Costa
* Orientadora: Christina von Flach G. Chavez
* Co-orientador: Paulo Roberto Miranda Meirelles


Survey
Qualitativo
Design Fixed
Explorative (primeiro experimento de caracterizacao)


# Passos de um experimento

* Scoping OK
* Planning OK
* Operation OK
* Analysis and interpretation OK
* Presentation and package

# Scope [why?]

## Goal

Analisar ferramentas de software                               [objects of study]
com o objetivo de caracterizar                                 [purpose]
em respeito à sua manutenabilidade                             [quality focus]
do ponto de vista de pesquisadores                             [perspective]
no contexto de ferramentas de análise estática de código fonte [context]

# Planning [how?]

## Context selection

* Tipo do experimento: Multi-object variation study
* Válido para um contexto específico, ferramentas de análise estática
* professional
* real problems
* Specific

## Hypothesis Formulation

* H0: não existe correlação entre características das ferramentas de análise estática e sua manutenabilidade
* H1: existe correlação entre características das ferramentas de análise estática e sua manutenabilidade

## Variables selection

* Independent variables: características das ferramentas de análise estática
* Dependent variables: nível de manutenabilidade das ferramentas de análise estática

## Selection of subjects

* Os "sujeitos" são os próprios "objetos" e a amostra é por conveniência.

## Experiment design

### Choice of experiment design

* Comparar a manutenabilidade das ferramentas agrupando-as por caractarísticas diferentes
* Avaliar quais características influenciam nas métricas que representam manutenabilidade

### General design principles

Randomization: para cumprir este princípio irei comparar com o maior número
               de características das ferramentas possíveis

Blocking: estou usando a técnica blocking para isolar efeitos colaterais na
          interpretação das métricas em relação ao domínio de aplicação, à linguagem de
          programação, ao tamanho do software em número de classes, todos são efeitos
          conhecidos que afetam a medida de algumas métricas

Balancing: também usei esta técnica ao selecionar releases das ferramentas que
           serão analisadas longitudemente, usei o mesmo número de releases (13)

### Standard design types

O meu experimento será do tipo "One factor with more than two treatments"

* Factor: manutenabilidade das ferramentas de análise estática
* Treatment: comparação entre grupos com características distintas

## Instrumentation

* Selecionar as ferramentas de análise estática
* Obter o código-fonte das ferramentas selecionadas
* Definir como calcular a manutenabilidade dessas ferramentas
* Preparar a coleta das métricas para cálculo da manutenabilidade
* Como agrupar os valores das métricas para testes

## Validity evaluation

* O estudo é válido para o domínio de ferramentas de análise estática

# Operation

(descrever como foi feito cada passo, cada coleta, detalhes práticos)

* Coleta de dados: Métricas de código fonte coletadas automaticamente
* Caracterização das ferramentas, revisao estruturada

# Analysis and Interpretation

data from the operation is input to the analysis and interpretation.

* Estatistica descritiva
* Dataset reduction
* Teste de hipótese

## Teste de hipótese

O teste de hipótese é uma tentativa de rejeitar a hipótese nula

Kruskal-Wallis: método não-paramétrica, usado em "um fator e muitos tratamentos"













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

Além do ambiente LaTeX é necessário instalar as dependencias do script para
extração e análise dos dados utilizados neste estudo, localizado em
`./dataset/analize-all-projects` (não é necessário executar este script
manualmente).

    apt-get install libmodern-perl-perl sloccount

Instale também as ferramentas `analizo` e `doxyparse` seguindo as
instruções em:

* http://www.analizo.org/installation.html

Apesar de não ser necessário executar o script para extração e análise dos
dados manualmente ele pode ser executado da seguinte forma:

    cd dataset
    ./analyze-all-projects

### Compilar

Após instalar todas as dependências basta executar o `make` na raiz do projeto.

    make

## Script para revisão estruturada semi-automatizada

O script `revisao-estruturada/filter` depende do comando `pdftotext`.

    apt-get install poppler-utils

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
* Crescêncio

## Crétidos

### Imagens e ícones

* https://openclipart.org/detail/237990/pdf
* https://openclipart.org/detail/65635/software-carton-box-with-no-text-remix

## Contato

joenio EM joenio.me
