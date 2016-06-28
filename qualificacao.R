library(knitr)
library(xtable)

# global options for knitr
opts_chunk$set(echo=FALSE, cache=TRUE, fig.pos='h')

metric_by_project <- function(metric) {
  metrics = read.table("dataset/analizo.metrics.dat")
  accessanalysis = metrics["accessanalysis", metric]
  bakarali = metrics["bakar-ali", metric]
  errorprone = metrics["error-prone", metric]
  indus = metrics["indus", metric]
  inputtracer = metrics["inputtracer", metric]
  jastadd = metrics["jastadd", metric]
  sourcemeter = metrics["source-meter", metric]
  # está dando erro de sintaxe no R ao ler o arquivo .dat
  #simplicissimus =
  srcml = metrics["srcml", metric]
  tacle = metrics["tacle", metric]
  wala = metrics["wala", metric]
  table = data.frame(accessanalysis, bakarali, errorprone, indus, inputtracer, jastadd, sourcemeter, srcml, tacle, wala)
  return(table)
}

metric_by_nist_project <- function(metric) {
  metrics = read.table("dataset/analizo.metrics.dat")
  boon = metrics["boon", metric]
  clang = metrics["clang", metric]
  closure = metrics["closure", metric]
  cppcheck = metrics["cppcheck", metric]
  cqual = metrics["cqual", metric]
  findbugs = metrics["findbugs", metric]
  findsecuritybugs = metrics["findsecuritybugs", metric]
  jlint = metrics["jlint", metric]
  pixy = metrics["pixy", metric]
  pmd = metrics["pmd", metric]
  rats = metrics["rats", metric]
  smatch = metrics["smatch", metric]
  splint = metrics["splint", metric]
  uno = metrics["uno", metric]
  wap = metrics["wap", metric]
  table = data.frame(boon, clang, closure, cppcheck, cqual, findbugs, findsecuritybugs, jlint, pixy, pmd, rats, smatch, splint, uno, wap)
  return(table)
}

percentis_for_metric <- function(metric, filename) {
  metrics = read.table(filename)
  percentis = quantile(metrics[, c(metric)], c(.01, .05, .10, .25, .50, .75, .90, .95, .99))
  return(percentis)
}

percentis_by_nist_project <- function(metric) {
  boon = percentis_for_metric(metric, "dataset/NIST/boon/boon-1.0.analizo.metrics.dat")
  clang = percentis_for_metric(metric, "dataset/NIST/clang/clang-tools-extra-3.7.1.src.analizo.metrics.dat")
  closure = percentis_for_metric(metric, "dataset/NIST/closure-compiler/compiler-latest.analizo.metrics.dat")
  cppcheck = percentis_for_metric(metric, "dataset/NIST/cppcheck/cppcheck-1.72.analizo.metrics.dat")
  cqual = percentis_for_metric(metric, "dataset/NIST/cqual/cqual-0.981.analizo.metrics.dat")
  findbugs = percentis_for_metric(metric, "dataset/NIST/findbugs/findbugs-3.0.1.analizo.metrics.dat")
  findsecuritybugs = percentis_for_metric(metric, "dataset/NIST/findsecuritybugs/findsecbugs-plugin-1.4.5-sources.analizo.metrics.dat")
  jlint = percentis_for_metric(metric, "dataset/NIST/jlint/jlint-3.1.2.analizo.metrics.dat")
  pixy = percentis_for_metric(metric, "dataset/NIST/pixy/pixy-master.analizo.metrics.dat")
  pmd = percentis_for_metric(metric, "dataset/NIST/pmd/pmd-src-5.4.1.analizo.metrics.dat")
  rats = percentis_for_metric(metric, "dataset/NIST/rats/rats-2.4.analizo.metrics.dat")
  smatch = percentis_for_metric(metric, "dataset/NIST/smatch/smatch.git.analizo.metrics.dat")
  splint = percentis_for_metric(metric, "dataset/NIST/splint/splint-3.1.2.analizo.metrics.dat")
  uno = percentis_for_metric(metric, "dataset/NIST/uno/uno.analizo.metrics.dat")
  wap = percentis_for_metric(metric, "dataset/NIST/wap/wap-2.1.analizo.metrics.dat")
  table = data.frame(boon, clang, closure, cppcheck, cqual, findbugs, findsecuritybugs, jlint, pixy, pmd, rats, smatch, splint, uno, wap)
  return(table)
}

percentis_by_project <- function(metric) {
  accessanalysis = percentis_for_metric(metric, "dataset/PAPERS/accessanalysis/AccessAnalysis-1.2-src.analizo.metrics.dat")
  bakarali = percentis_for_metric(metric, "dataset/PAPERS/bakar-ali/bakar-dev-20160415-002013.analizo.metrics.dat")
  errorprone = percentis_for_metric(metric, "dataset/PAPERS/error-prone/error-prone-2.0.9.analizo.metrics.dat")
  indus = percentis_for_metric(metric, "dataset/PAPERS/indus/indus.analizo.metrics.dat")
  inputtracer = percentis_for_metric(metric, "dataset/PAPERS/inputtracer/valgrind-inputtracer.analizo.metrics.dat")
  jastadd = percentis_for_metric(metric, "dataset/PAPERS/jastadd/jastadd2-src.analizo.metrics.dat")
  sourcemeter = percentis_for_metric(metric, "dataset/PAPERS/source-meter/SonarQube-plug-in-master.analizo.metrics.dat")
  # está dando erro de sintaxe no R ao ler o arquivo .dat
  #simplicissimus = percentis_for_metric(metric, "dataset/PAPERS/simplicissimus/Simplicissimus.analizo.metrics.dat")
  srcml = percentis_for_metric(metric, "dataset/PAPERS/srcml/srcML-src.analizo.metrics.dat")
  tacle = percentis_for_metric(metric, "dataset/PAPERS/tacle/tacle_1_2_1_src.analizo.metrics.dat")
  wala = percentis_for_metric(metric, "dataset/PAPERS/wala/WALA-R_1.3.8.analizo.metrics.dat")
  table = data.frame(accessanalysis, bakarali, errorprone, indus, inputtracer, jastadd, sourcemeter, srcml, tacle, wala)
  return(table)
}

plot_lines_for_metric <- function(metric, filename) {
  percentis = percentis_for_metric(metric, filename)
  plot(percentis, type="o", xlab="percentis", ylab="valor", xaxt="n", cex.lab=0.6, cex.axis=0.6, cex.sub=0.6, cex.main=0.6)
  axis(1, at=1:length(percentis), labels=names(percentis), cex.axis=0.6)
  title(main=metric)
}

plot_lines_for_project <- function(filename) {
  plot_lines_for_metric("lcom4", filename)
  plot_lines_for_metric("cbo", filename)
  plot_lines_for_metric("sc", filename)
  plot_lines_for_metric("amloc", filename)
}

knitr_latex_table <- function(table, caption, label) {
  xtable(t(table), caption=caption, digits=c(0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1), label=label)
}

add_column <- function(table1, table2, colname) {
  t_colnames = c(paste(colname), rownames(table1))
  table = data.frame(t(table2), t(table1))
  colnames(table) <- t_colnames
  return(t(table))
}

knit("qualificacao.Rtex")
