Segunda rodada de analise dos papers do SCAM 2001 e 2003
========================================================

# Ferramentas de indústria

# Análise de ferramentas do NIST

Fonte de obtenção de ferramentas de análise estática do NIST:

* https://samate.nist.gov/index.php/Source_Code_Security_Analyzers.html

Link acima acessado em 28/jan/2016, obtive a seguinte lista de ferramentas com 54 itens:

Irei utilizar o sloccount para descobrir em que linguagem cada ferramenta é escrita,
o sloccount dá, dentre várias outras métricas, o número de linhas físicas por linguagem
de programação.

* ABASH | código fonte não encontrado
* ApexSec Security Console | proprietário, código-fonte não disponível
* Astrée | proprietário, código-fonte não disponível
* BOON | código disponível, mas os autores informam que é apenas um protótipo e que está descontinuado | ansic
* bugScout | código fonte não encontrado pra download, aparentemente proprietário
* C/C++test® | código fonte não disponível, propriatário
* dotTEST™ | idem acima
* Jtest® | idem acima
* HP Code Advisor (cadvise) | código não encontrado
* Checkmarx CxSAST | código fonte não encontrado
* Clang Static Analyzer | código fonte disponível, o projeto LLVM tem vários módulos, baixei apenas especificos do clang
* Closure Compiler | código fonte disponível | 
* CodeCenter | código fonte não encontrado | 
* CodePeer | código fonte não disponível, proprietário | 
* CodeSecure | site não briu, aparentemente offline
* CodeSonar | não disponível, solicitei uma Academic Program |
* Coverity SAVE™ | código não disponível | 
* Cppcheck | código disponível facilmente | 
* CQual | esse projeto foi movido pra dentro do Oink, informação na página inicial, mas o código ainda está disponível | 
* Csur | o site informa que um beta será disponibilizado em breve, mas não dispõe nada ainda | 
* DoubleCheck | código não encontrado, nem binários |
* FindBugs | código fonte disponível | 
* FindSecurityBugs | código fonte disponível facinho | 
* Flawfinder | código fonte disponível | 
* Fluid | código não encontrado | 
* Goanna Studio and Goanna Central | proprietário | 
* HP QAInspect | código não encontrado | 
* Insight | código não encontrado | 
* Jlint | livre, código encontrado fácil | 
* LAPSE | código encontrado, não mto fácil | 
* ObjectCenter | código não encontrado | 
* Parfait | código não disponível, proprietário Oracle | 
* PLSQLScanner 2008 | o site informa que essa ferramenta faz parte agora da repscan | 
* PHP-Sat | informa que não tem release estável ainda, tem código fonte mas links down | 
* Pixy | código fonte fácil no github \o/ | 
* PMD | código disponível fácil na página inicial | 
* PolySpace | proprietariozao | 
* PREfix and PREfast | nao disponivel, proprietario | 
* pylint | codigo facil, download ok | 
* QA-C, QA-C++, QA-J | código não disponível | 
* Qualitychecker | proprietário, código não disponível | 
* Rational AppScan Source Edition | disponível apenas trial sob solicitação | 
* RATS (Rough Auditing Tool for Security) | código facilmente encontrado | 
* Resource Standard Metrics (RSM) | disponível versão free apenas binários | 
* Smatch | código disponível no git | 
* SCA | código não encontrado | 
* SPARK tool set | proprietário | 
* Splint | código encontrado facinho | 
* TBmisra®, TBsecure® | código não encontrado | 
* UNO | código encontrado facil | um link aponta uma lista de outros analisadores estaticos http://spinroot.com/static/
* PVS-Studio | download binários .exe apenas, proprietário | 
* xg++ | código não encontrado | 
* Yasca | código disponível, ok | 
* WAP | código disponível, ok | 

Identificar em qual linguagem de programação a ferramenta é escrita
===================================================================

Os projetos estão sendo analizados com doxyparse versão 1.8.11 e analizo 1.19.0.

Irei analisar métricas globais relacionadas a tamanho e qualidade.
* change\_cost
* total\_loc
* lcom
* cbo

Métricas utilizadas por Marcos Ronaldo, inspiradas na tese de Paulo:

• Média de linhas de código por método - Average Method Lines Of Code (AMLOC)
• Média de complexidade ciclomática por método - Average Cyclomatic Complexity per Method (ACCM)
• Resposta para uma classe - Response For a Class (RFC)
• Profundidade na árvore de herança - Depth in Inheritance Tree (DIT)
• Número de subclasses - Number of Children (NOC)
• Falta de coesão em métodos - Lack of Cohesion in Methods (LCOM4)
• Conexões aferentes de uma classe - Afferent Connections per Class (ACC)
• Fator de acoplamento - Coupling Factor (COF)

# Extraindo metricas de todos os projetos

Foi criado um script `analyze-all-projects` que percorre todos os projetos
executa o analizo e coleta as métricas que tenho interesse, ao final
salva um arquivo "metrics.dat" com uma estrutura de tabela para ser
posteriormente importado no ambiente R.

A fazer:
* extrair numero de linhas

## Lançamentos

Closure Compiler}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2016 & 5  \\
        2015 & 9  \\
        2014 & 11 \\
        2013 & 19 \\
        \hline
      \end{tabular}
    \end{table}

\subsection{Cppcheck}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2016 & 3    \\
        2015 & 4    \\
        2014 & 5    \\
        2013 & 6    \\
        2012 & 5    \\
        2011 & 6    \\
        2010 & 8    \\
        2009 & 10   \\
        \hline
      \end{tabular}
    \end{table}

\subsection{CQual}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2004 & 2  \\
        2003 & 2  \\
        \hline
      \end{tabular}
    \end{table}

\subsection{FindBugs}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2015 & 1  \\
        2014 & 1  \\
        2013 & 1  \\
        2012 & 2  \\
        2011 & 1  \\
        2009 & 2  \\
        2008 & 4  \\
        2007 & 1  \\
        \hline
      \end{tabular}
    \end{table}

\subsection{FindSecurityBugs}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2016 & 2   \\
        2015 & 7   \\
        2014 & 1   \\
        2013 & 2   \\
        2012 & 1   \\
        \hline
      \end{tabular}
    \end{table}

\subsection{Jlint}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2011 & 1  \\
        2010 & 1  \\
        2006 & 1  \\
        2004 & 1  \\
        \hline
      \end{tabular}
    \end{table}

\subsection{Pixy}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2012 & 1      \\
        \hline
      \end{tabular}
    \end{table}

\subsection{PMD}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2016 & 3   \\
        2015 & 9   \\
        2014 & 8   \\
        2013 & 4   \\
        2012 & 2   \\
        2011 & 2   \\
        2009 & 1   \\
        \hline
      \end{tabular}
    \end{table}

\subsection{RATS}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2013 & 1   \\
        2009 & 1   \\
        ??   & 1   \\
        \hline
      \end{tabular}
    \end{table}

\subsection{Smatch}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2015 & 1  \\
        2013 & 3  \\
        2012 & 1  \\
        2010 & 2  \\
        2009 & 3  \\
        \hline
      \end{tabular}
    \end{table}

\subsection{Splint}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2007 & 1  \\
        2003 & 1  \\
        ??   & 1  \\
        2002 & 1  \\
        ??   & 4  \\
        ??   & 3  \\
        2001 & 1  \\
        \hline
      \end{tabular}
    \end{table}

\subsection{UNO}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2007 & 3   \\
        2006 & 1   \\
        2005 & 5   \\
        2004 & 5   \\
        2003 & 7   \\
        \hline
      \end{tabular}
    \end{table}

\subsection{WAP}
    \begin{table}[h!]
      \centering
      \begin{tabular}{| l | l |}
        \hline
        Ano  & Nº de lançamentos \\
        \hline
        2015 & 7  \\
        \hline
      \end{tabular}
    \end{table}

