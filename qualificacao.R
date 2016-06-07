library(knitr)

percentis_for_metric <- function(metric, filename) {
  metrics = read.table(filename)
  percentis = quantile(metrics[, c(metric)], c(.01, .05, .10, .25, .50, .75, .90, .95, .99))
  return(percentis)
}

percentis_by_metric <- function(filename) {
  accm = percentis_for_metric("accm", filename)
  acc = percentis_for_metric("acc", filename)
  amloc = percentis_for_metric("amloc", filename)
  anpm = percentis_for_metric("anpm", filename)
  cbo = percentis_for_metric("cbo", filename)
  dit = percentis_for_metric("dit", filename)
  lcom4 = percentis_for_metric("lcom4", filename)
  loc = percentis_for_metric("loc", filename)
  mmloc = percentis_for_metric("mmloc", filename)
  noa = percentis_for_metric("noa", filename)
  noc = percentis_for_metric("noc", filename)
  noc = percentis_for_metric("noc", filename)
  nom = percentis_for_metric("nom", filename)
  npa = percentis_for_metric("npa", filename)
  npm = percentis_for_metric("npm", filename)
  rfc = percentis_for_metric("rfc", filename)
  sc = percentis_for_metric("sc", filename)
  table = data.frame(acc, accm, amloc, anpm, cbo, dit, lcom4, loc, mmloc, noa, noc, nom, npa, npm, rfc, sc)
  return(table)
}

percentis_by_project <- function(metric) {
  accessanalysis = percentis_for_metric(metric, "dataset/PAPERS/accessanalysis/AccessAnalysis-1.2-src.analizo.metrics.dat")
  bakarali = percentis_for_metric(metric, "dataset/PAPERS/bakar-ali/bakar-dev-20160415-002013.analizo.metrics.dat")
  errorprone = percentis_for_metric(metric, "dataset/PAPERS/error-prone/error-prone-2.0.9.analizo.metrics.dat")
  indus = percentis_for_metric(metric, "dataset/PAPERS/indus/indus.staticanalyses.analizo.metrics.dat")
  inputtracer = percentis_for_metric(metric, "dataset/PAPERS/inputtracer/valgrind-inputtracer.analizo.metrics.dat")
  jastadd = percentis_for_metric(metric, "dataset/PAPERS/jastadd/jastadd2-src.analizo.metrics.dat")
  sourcemeter = percentis_for_metric(metric, "dataset/PAPERS/source-meter/SonarQube-plug-in-master.analizo.metrics.dat")
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
  plot_lines_for_metric("acc", filename)
  plot_lines_for_metric("rfc", filename)
  plot_lines_for_metric("accm", filename)
}

knit("qualificacao.Rtex")
