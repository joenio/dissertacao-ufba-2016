library(knitr)
library(xtable)

# global options for knitr
opts_chunk$set(echo=FALSE, cache=TRUE, fig.pos='h')

metric_by_project <- function(metric) {
  metrics = read.table("dataset/analizo.metrics.dat")
  accessanalysis = metrics["accessanalysis", metric]
  bogor = metrics["bogor", metric]
  composite = metrics["composite", metric]
  cseq = metrics["cseq", metric]
  ejb = metrics["ejb", metric]
  errorprone = metrics["error-prone", metric]
  guizmo = metrics["guizmo", metric]
  gumtree = metrics["guizmo", metric]
  indus = metrics["indus", metric]
  inputtracer = metrics["inputtracer", metric]
  jastadd = metrics["jastadd", metric]
  jflow = metrics["jflow", metric]
  lotrack = metrics["lotrack", metric]
  mpanalyzer = metrics["mpanalyzer", metric]
  ptyasm = metrics["ptyasm", metric]
  reassert = metrics["reassert", metric]
  sonarqubeplugin = metrics["sonarqube-plugin", metric]
  sparta = metrics["sparta", metric]
  srcml = metrics["srcml", metric]
  tacle = metrics["tacle", metric]
  wala = metrics["wala", metric]
  table = data.frame(accessanalysis, bogor, composite, cseq, ejb, errorprone, guizmo, gumtree, indus, inputtracer, jastadd, jflow, lotrack, mpanalyzer, ptyasm, reassert, sonarqubeplugin, sparta, srcml, tacle, wala)
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
  #clang = percentis_for_metric(metric, "dataset/static-analysis-tools/clang/cfe-3.7.1.src.analizo.metrics.dat")

  closure = percentis_for_metric(metric, "dataset/static-analysis-tools/closure-compiler/closure-compiler-closure-compiler-parent-v20160619.analizo.metrics.dat")
  cppcheck = percentis_for_metric(metric, "dataset/static-analysis-tools/cppcheck/cppcheck-1.72.analizo.metrics.dat")
  cqual = percentis_for_metric(metric, "dataset/static-analysis-tools/cqual/cqual-0.981.analizo.metrics.dat")
  findbugs = percentis_for_metric(metric, "dataset/static-analysis-tools/findbugs/findbugs-3.0.1.analizo.metrics.dat")
  findsecuritybugs = percentis_for_metric(metric, "dataset/static-analysis-tools/findsecuritybugs/findsecbugs-plugin-1.4.5-sources.analizo.metrics.dat")
  jlint = percentis_for_metric(metric, "dataset/static-analysis-tools/jlint/jlint-3.1.2.analizo.metrics.dat")
  pixy = percentis_for_metric(metric, "dataset/static-analysis-tools/pixy/pixy-master.analizo.metrics.dat")
  pmd = percentis_for_metric(metric, "dataset/static-analysis-tools/pmd/pmd-src-5.4.1.analizo.metrics.dat")
  rats = percentis_for_metric(metric, "dataset/static-analysis-tools/rats/rats-2.4.analizo.metrics.dat")
  smatch = percentis_for_metric(metric, "dataset/static-analysis-tools/smatch/smatch.git.analizo.metrics.dat")
  splint = percentis_for_metric(metric, "dataset/static-analysis-tools/splint/splint-3.1.2.analizo.metrics.dat")
  uno = percentis_for_metric(metric, "dataset/static-analysis-tools/uno/uno.analizo.metrics.dat")
  wap = percentis_for_metric(metric, "dataset/static-analysis-tools/wap/wap-2.1.analizo.metrics.dat")
  #table = data.frame(clang, closure, cppcheck, cqual, findbugs, findsecuritybugs, jlint, pixy, pmd, rats, smatch, splint, uno, wap)
  table = data.frame(closure, cppcheck, cqual, findbugs, findsecuritybugs, jlint, pixy, pmd, rats, smatch, splint, uno, wap)
  return(table)
}

percentis_by_project <- function(metric) {
  accessanalysis = percentis_for_metric(metric, "dataset/static-analysis-tools/accessanalysis/AccessAnalysis-1.2-src.analizo.metrics.dat")
  bogor = percentis_for_metric(metric, "dataset/static-analysis-tools/bogor/bogor-core.analizo.metrics.dat")
  composite = percentis_for_metric(metric, "dataset/static-analysis-tools/composite/composite-0.4.analizo.metrics.dat")
  cseq = percentis_for_metric(metric, "dataset/static-analysis-tools/cseq/cseq-0.5.analizo.metrics.dat")
  ejb = percentis_for_metric(metric, "dataset/static-analysis-tools/ejb/EJB.analizo.metrics.dat")
  errorprone = percentis_for_metric(metric, "dataset/static-analysis-tools/error-prone/error-prone-2.0.9.analizo.metrics.dat")
  guizmo = percentis_for_metric(metric, "dataset/static-analysis-tools/guizmo/guizmo-master.analizo.metrics.dat")
  gumtree = percentis_for_metric(metric, "dataset/static-analysis-tools/gumtree/gumtree-2.0.0.analizo.metrics.dat")
  indus = percentis_for_metric(metric, "dataset/static-analysis-tools/indus/indus.analizo.metrics.dat")
  inputtracer = percentis_for_metric(metric, "dataset/static-analysis-tools/inputtracer/valgrind-inputtracer.analizo.metrics.dat")
  jastadd = percentis_for_metric(metric, "dataset/static-analysis-tools/jastadd/jastadd2-src.analizo.metrics.dat")
  jflow = percentis_for_metric(metric, "dataset/static-analysis-tools/jflow/vazexqi-JFlow-7cd7eaf.analizo.metrics.dat")
  lotrack = percentis_for_metric(metric, "dataset/static-analysis-tools/lotrack/Lotrack-master.analizo.metrics.dat")
  mpanalyzer = percentis_for_metric(metric, "dataset/static-analysis-tools/mpanalyzer/MPAnalyzer-master.analizo.metrics.dat")
  ptyasm = percentis_for_metric(metric, "dataset/static-analysis-tools/ptyasm/ptyasm.analizo.metrics.dat")
  reassert = percentis_for_metric(metric, "dataset/static-analysis-tools/reassert/ReAssert_0.4.1.analizo.metrics.dat")
  sonarqubeplugin = percentis_for_metric(metric, "dataset/static-analysis-tools/sonarqube-plugin/SonarQube-plug-in-master.analizo.metrics.dat")
  sparta = percentis_for_metric(metric, "dataset/static-analysis-tools/sparta/sparta-sparta-1.0.2.analizo.metrics.dat")
  srcml = percentis_for_metric(metric, "dataset/static-analysis-tools/srcml/srcML-src.analizo.metrics.dat")
  tacle = percentis_for_metric(metric, "dataset/static-analysis-tools/tacle/tacle_1_2_1_src.analizo.metrics.dat")
  wala = percentis_for_metric(metric, "dataset/static-analysis-tools/wala/WALA-R_1.3.8.analizo.metrics.dat")
  table = data.frame(accessanalysis, bogor, composite, cseq, ejb, errorprone, guizmo, gumtree, indus, inputtracer, jastadd, jflow, lotrack, mpanalyzer, ptyasm, reassert, sonarqubeplugin, sparta, srcml, tacle, wala)
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
  xt <- xtable(t(table), caption=caption, digits=c(0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1), label=label)
  write.csv(xt, file=paste("dataset/metricas/", label, ".csv", sep=""))
  print(xt, table.placement="H", caption.placement="top")
}

add_column <- function(table1, newcolumn, colname) {
  t_colnames = c(paste(colname), rownames(table1))
  table = data.frame(t(newcolumn), t(table1))
  colnames(table) <- t_colnames
  return(t(table))
}

add_column_at_end <- function(table1, newcolumn, colname) {
  t_colnames = c(rownames(table1), paste(colname))
  table = data.frame(t(table1), t(newcolumn))
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

histograma <- function(metric, caption) {
  accessanalysis = read.table("dataset/static-analysis-tools/accessanalysis/AccessAnalysis-1.2-src.analizo.metrics.dat")
  ejb = read.table("dataset/static-analysis-tools/ejb/EJB.analizo.metrics.dat")
  errorprone = read.table("dataset/static-analysis-tools/error-prone/error-prone-2.0.9.analizo.metrics.dat")
  indus = read.table("dataset/static-analysis-tools/indus/indus.analizo.metrics.dat")
  inputtracer = read.table("dataset/static-analysis-tools/inputtracer/valgrind-inputtracer.analizo.metrics.dat")
  jastadd = read.table("dataset/static-analysis-tools/jastadd/jastadd2-src.analizo.metrics.dat")
  sonarqubeplugin = read.table("dataset/static-analysis-tools/sonarqube-plugin/SonarQube-plug-in-master.analizo.metrics.dat")
  srcml = read.table("dataset/static-analysis-tools/srcml/srcML-src.analizo.metrics.dat")
  tacle = read.table("dataset/static-analysis-tools/tacle/tacle_1_2_1_src.analizo.metrics.dat")
  wala = read.table("dataset/static-analysis-tools/wala/WALA-R_1.3.8.analizo.metrics.dat")

  closure = read.table("dataset/static-analysis-tools/closure-compiler/closure-compiler-closure-compiler-parent-v20160619.analizo.metrics.dat")
  cppcheck = read.table("dataset/static-analysis-tools/cppcheck/cppcheck-1.72.analizo.metrics.dat")
  cqual = read.table("dataset/static-analysis-tools/cqual/cqual-0.981.analizo.metrics.dat")
  findbugs = read.table("dataset/static-analysis-tools/findbugs/findbugs-3.0.1.analizo.metrics.dat")
  findsecuritybugs = read.table("dataset/static-analysis-tools/findsecuritybugs/findsecbugs-plugin-1.4.5-sources.analizo.metrics.dat")
  jlint = read.table("dataset/static-analysis-tools/jlint/jlint-3.1.2.analizo.metrics.dat")
  pixy = read.table("dataset/static-analysis-tools/pixy/pixy-master.analizo.metrics.dat")
  pmd = read.table("dataset/static-analysis-tools/pmd/pmd-src-5.4.1.analizo.metrics.dat")
  rats = read.table("dataset/static-analysis-tools/rats/rats-2.4.analizo.metrics.dat")
  smatch = read.table("dataset/static-analysis-tools/smatch/smatch.git.analizo.metrics.dat")
  splint = read.table("dataset/static-analysis-tools/splint/splint-3.1.2.analizo.metrics.dat")
  uno = read.table("dataset/static-analysis-tools/uno/uno.analizo.metrics.dat")
  wap = read.table("dataset/static-analysis-tools/wap/wap-2.1.analizo.metrics.dat")

  x = c(accessanalysis[,metric], ejb[,metric], errorprone[,metric], indus[,metric], inputtracer[,metric], jastadd[,metric], sonarqubeplugin[,metric], srcml[,metric], tacle[,metric], wala[,metric], closure[,metric], cppcheck[,metric], cqual[,metric], findbugs[,metric], findsecuritybugs[,metric], jlint[,metric], pixy[,metric], pmd[,metric], rats[,metric], smatch[,metric], splint[,metric], uno[,metric], wap[,metric])

  par(oma=c(0, 0, 0, 0), mar=c(2, 4, 1, 0))
  nonzeros = x[x > 0 & x < 500]
  h = hist(nonzeros, main=metric, xlab="valor", ylab="frequência")
  xfit <- seq(min(nonzeros), max(nonzeros), length=40)
  yfit <- dnorm(xfit, mean=mean(nonzeros), sd=sd(nonzeros))
  yfit <- yfit*diff(h$mids[1:2])*length(nonzeros)
  lines(xfit, yfit, col="blue", lwd=4)
}

knit("_dissertacao.Rtex")
