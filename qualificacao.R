library(knitr)
library(xtable)

# global options for knitr
opts_chunk$set(echo=FALSE, cache=TRUE, fig.pos='h')

metric_by_project <- function(metric) {
  metrics = read.table("dataset/analizo.metrics.dat")
  accessanalysis = metrics["accessanalysis", metric]
  errorprone = metrics["error-prone", metric]
  indus = metrics["indus", metric]
  inputtracer = metrics["inputtracer", metric]
  jastadd = metrics["jastadd", metric]
  sonarqubeplugin = metrics["sonarqube-plugin", metric]
  # está dando erro de sintaxe no R ao ler o arquivo .dat
  #simplicissimus =
  srcml = metrics["srcml", metric]
  tacle = metrics["tacle", metric]
  wala = metrics["wala", metric]
  table = data.frame(accessanalysis, errorprone, indus, inputtracer, jastadd, sonarqubeplugin, srcml, tacle, wala)
  return(table)
}

metric_by_nist_project <- function(metric) {
  metrics = read.table("dataset/analizo.metrics.dat")
  #clang = metrics["clang", metric]
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
  #table = data.frame(clang, closure, cppcheck, cqual, findbugs, findsecuritybugs, jlint, pixy, pmd, rats, smatch, splint, uno, wap)
  table = data.frame(closure, cppcheck, cqual, findbugs, findsecuritybugs, jlint, pixy, pmd, rats, smatch, splint, uno, wap)
  return(table)
}

percentis_for_metric <- function(metric, filename) {
  metrics = read.table(filename)
  percentis = quantile(metrics[, c(metric)], c(.01, .05, .10, .25, .50, .75, .90, .95, .99))
  return(percentis)
}

percentis_by_nist_project <- function(metric) {
  #clang = percentis_for_metric(metric, "dataset/NIST/clang/cfe-3.7.1.src.analizo.metrics.dat")

  closure = percentis_for_metric(metric, "dataset/NIST/closure-compiler/closure-compiler-closure-compiler-parent-v20160619.analizo.metrics.dat")
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
  #table = data.frame(clang, closure, cppcheck, cqual, findbugs, findsecuritybugs, jlint, pixy, pmd, rats, smatch, splint, uno, wap)
  table = data.frame(closure, cppcheck, cqual, findbugs, findsecuritybugs, jlint, pixy, pmd, rats, smatch, splint, uno, wap)
  return(table)
}

percentis_by_project <- function(metric) {
  accessanalysis = percentis_for_metric(metric, "dataset/PAPERS/accessanalysis/AccessAnalysis-1.2-src.analizo.metrics.dat")
  errorprone = percentis_for_metric(metric, "dataset/PAPERS/error-prone/error-prone-2.0.9.analizo.metrics.dat")
  indus = percentis_for_metric(metric, "dataset/PAPERS/indus/indus.analizo.metrics.dat")
  inputtracer = percentis_for_metric(metric, "dataset/PAPERS/inputtracer/valgrind-inputtracer.analizo.metrics.dat")
  jastadd = percentis_for_metric(metric, "dataset/PAPERS/jastadd/jastadd2-src.analizo.metrics.dat")
  sonarqubeplugin = percentis_for_metric(metric, "dataset/PAPERS/sonarqube-plugin/SonarQube-plug-in-master.analizo.metrics.dat")
  # está dando erro de sintaxe no R ao ler o arquivo .dat
  #simplicissimus = percentis_for_metric(metric, "dataset/PAPERS/simplicissimus/Simplicissimus.analizo.metrics.dat")
  srcml = percentis_for_metric(metric, "dataset/PAPERS/srcml/srcML-src.analizo.metrics.dat")
  tacle = percentis_for_metric(metric, "dataset/PAPERS/tacle/tacle_1_2_1_src.analizo.metrics.dat")
  wala = percentis_for_metric(metric, "dataset/PAPERS/wala/WALA-R_1.3.8.analizo.metrics.dat")
  table = data.frame(accessanalysis, errorprone, indus, inputtracer, jastadd, sonarqubeplugin, srcml, tacle, wala)
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
  xt <- xtable(t(table), caption=caption, digits=c(0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1), label=label)
  print(xt, table.placement="H")
}

add_column <- function(table1, table2, colname) {
  t_colnames = c(paste(colname), rownames(table1))
  table = data.frame(t(table2), t(table1))
  colnames(table) <- t_colnames
  return(t(table))
}

percentil_all_projects <- function(percentil) {
  table = percentis_by_project("acc")
  acc = table[c(percentil),]
  table = percentis_by_project("accm")
  accm = table[c(percentil),]
  table = percentis_by_project("amloc")
  amloc = table[c(percentil),]
  table = percentis_by_project("anpm")
  anpm = table[c(percentil),]
  table = percentis_by_project("cbo")
  cbo = table[c(percentil),]
  table = percentis_by_project("lcom4")
  lcom4 = table[c(percentil),]
  table = percentis_by_project("loc")
  loc = table[c(percentil),]
  table = percentis_by_project("noa")
  noa = table[c(percentil),]
  table = percentis_by_project("nom")
  nom = table[c(percentil),]
  table = percentis_by_project("npa")
  npa = table[c(percentil),]
  table = percentis_by_project("npm")
  npm = table[c(percentil),]
  table = percentis_by_project("rfc")
  rfc = table[c(percentil),]
  table = percentis_by_project("sc")
  sc = table[c(percentil),]
  table = data.frame(t(acc), t(accm), t(amloc), t(anpm), t(cbo), t(lcom4), t(loc), t(noa), t(nom), t(npa), t(npm), t(rfc), t(sc))
  colnames(table) = c('acc', 'accm', 'amloc', 'anpm', 'cbo', 'lcom4', 'loc', 'noa', 'nom', 'npa', 'npm', 'rfc', 'sc')
  return(table)
}

percentil_all_nist_projects <- function(percentil) {
  table = percentis_by_nist_project("acc")
  acc = table[c(percentil),]
  table = percentis_by_nist_project("accm")
  accm = table[c(percentil),]
  table = percentis_by_nist_project("amloc")
  amloc = table[c(percentil),]
  table = percentis_by_nist_project("anpm")
  anpm = table[c(percentil),]
  table = percentis_by_nist_project("cbo")
  cbo = table[c(percentil),]
  table = percentis_by_nist_project("lcom4")
  lcom4 = table[c(percentil),]
  table = percentis_by_nist_project("loc")
  loc = table[c(percentil),]
  table = percentis_by_nist_project("noa")
  noa = table[c(percentil),]
  table = percentis_by_nist_project("nom")
  nom = table[c(percentil),]
  table = percentis_by_nist_project("npa")
  npa = table[c(percentil),]
  table = percentis_by_nist_project("npm")
  npm = table[c(percentil),]
  table = percentis_by_nist_project("rfc")
  rfc = table[c(percentil),]
  table = percentis_by_nist_project("sc")
  sc = table[c(percentil),]
  table = data.frame(t(acc), t(accm), t(amloc), t(anpm), t(cbo), t(lcom4), t(loc), t(noa), t(nom), t(npa), t(npm), t(rfc), t(sc))
  colnames(table) = c('acc', 'accm', 'amloc', 'anpm', 'cbo', 'lcom4', 'loc', 'noa', 'nom', 'npa', 'npm', 'rfc', 'sc')
  return(table)
}

knit("_qualificacao.Rtex")
