#!/bin/sh

NIST='boon
      clang
      closure-compiler
      cppcheck
      cqual
      findbugs
      findsecuritybugs
      jlint
      pixy
      pmd
      rats
      smatch
      splint
      uno
      wap'

PAPERS='source-meter
        srcml
        wala
        error-prone
        indus
        tacle
        jastadd
        accessanalysis
        bakar-ali
        inputtracer'

analyze_project() {
  source=$1
  project=$2
  for dir in `ls $source/$project`; do
    if [ -d $source/$project/$dir ]; then
      if [ ! -e $source/$project/$dir.doxyparse ]; then
        echo "doxyparse $source/$project/$dir > $source/$project/$dir.doxyparse"
        doxyparse $source/$project/$dir > $source/$project/$dir.doxyparse
      fi
      if [ ! -e $source/$project/$dir.analizo.metrics ]; then
        echo "analizo metrics $source/$project/$dir > $source/$project/$dir.analizo.metrics"
        analizo metrics $source/$project/$dir > $source/$project/$dir.analizo.metrics
      fi
      if [ ! -e $source/$project/$dir.sloccount ]; then
        echo "sloccount $source/$project/$dir > $source/$project/$dir.sloccount"
        sloccount $source/$project/$dir > $source/$project/$dir.sloccount
      fi
    fi
  done
}

# run doxyparse and analizo metrics each project
for project in $NIST; do
  analyze_project 'NIST' $project
done
for project in $PAPERS; do
  analyze_project 'PAPERS' $project
done

PROJECT_METRICS='noc_mean
         accm_mean
         amloc_mean
         lcom4_mean
         cbo_mean
         dit_mean
         rfc_mean
         sc_mean
         total_cof'

echo_project_metrics() {
  source=$1
  project=$2
  for dir in `ls $source/$project`; do
    if [ -d $source/$project/$dir ]; then
      if [ -e $source/$project/$dir.analizo.metrics ]; then
        echo -n "$source:$dir"
        for metric in $PROJECT_METRICS; do
          value=`grep $metric: $source/$project/$dir.analizo.metrics`
          value=`echo $value | sed "s/.\+: //g"`
          printf " %.2f" $value
        done
        echo ""
      fi
    fi
  done
}

echo_module_metric() {
  source=$1
  project=$2
  metric=$3
  for file in `ls $source/$project/*.metrics`; do
    metrics=$(grep '^loc:' $file | sed "s/.\+: //g")
  done
  echo $metrics
}


echo -n $PROJECT_METRICS
echo ""
for project in $NIST; do
  echo_project_metrics 'NIST' $project
done
for project in $PAPERS; do
  echo_project_metrics 'PAPERS' $project
done
