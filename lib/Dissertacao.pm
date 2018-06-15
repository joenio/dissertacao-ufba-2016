package Dissertacao;
use strict;
use Exporter 'import';
use Text::BibTeX ':subs';
use List::Util qw( all uniq );
use YAML::XS qw( LoadFile );
use Statistics::Descriptive;
use File::Spec::Functions;
use vars qw(@EXPORT_OK @EXPORT);

# symbols to export on request
@EXPORT_OK = qw(
  equal
  unique
  foreach_bibtex_entry
  query
  bibtex_load
  count_mentions_by_type
  find_references
  metrics_load
  years_mentioned
  count_total
  count_included
  sort_ids
  count_software_mentioned_by_type_and_conf
  count_software_mentioned_by_type
  load_dataset_cache_file
  papers_count
  papers_filter_count
  papers_extraction_count
);

use constant ROOT => $ENV{PWD};

@EXPORT = qw(
  ROOT
);

sub papers_count {
  count_total(catfile(ROOT, 'dataset', 'papers', 'filter-papers-ase.md')) +
    count_total(catfile(ROOT, 'dataset', 'papers', 'filter-papers-scam.md'));
}

sub papers_filter_count {
  count_included(catfile(ROOT, 'dataset', 'papers', 'filter-papers-ase.md')) +
    count_included(catfile(ROOT, 'dataset', 'papers', 'filter-papers-scam.md'));
}

sub papers_extraction_count {
  my %dataset = @_;
  my @papers = ();
  foreach my $k (keys %dataset) {
    foreach my $id (keys %{ $dataset{$k}{references} }) {
      if ($dataset{$k}{references}{$id}{is_software_mentioned} eq 'yes') {
        if ($dataset{$k}{references}{$id}{step} && $dataset{$k}{references}{$id}{step} eq 'study1') {
          push @papers, $id;
        }
      }
    }
  }
  uniq @papers;
}

sub load_dataset_cache_file {
  my $DATASET_FILENAME = catfile(ROOT, 'cache', 'dataset.yml');
  unless (-e $DATASET_FILENAME) {
    die "dataset file not found: $DATASET_FILENAME, please run `make cache` first!";
  }
  LoadFile $DATASET_FILENAME;
}

sub equal {
  my ($a, $b) = @_;
  my $title = $a->get('title');
  my $doi = $a->get('doi') // undef;
  if ($title && $b->get('title') && lc($b->get('title')) eq lc($title)) {
    return 1;
  }
  elsif ($doi && $b->get('doi') && $doi eq $b->get('doi')) {
    return 1;
  }
  return 0;
}

sub unique {
  my %references = @_;
  my %uniq = ();
  foreach my $k (sort keys %references) {
    unless (grep { equal($references{$k}, $uniq{$_}) } keys %uniq) {
      $uniq{$k} = $references{$k};
    }
  }
  return %uniq;
}

sub foreach_bibtex_entry {
  my $block = pop;
  my @FILES = @_;
  while (my $filename = shift @FILES) {
    next if -z $filename;
    if (my $bib = Text::BibTeX::File->new($filename)) {
      while (my $entry = Text::BibTeX::Entry->new({binmode => 'utf-8'}, $bib)) {
        next unless $entry->parse_ok;
        &$block($entry);
      }
    }
  }
}

# discard entries with no title
sub bibtex_load {
  my @FILES = @_;
  my %references = ();
  foreach_bibtex_entry(@FILES, sub {
    my $entry = shift;
    $references{$entry->key} = $entry if $entry->get('title');
  });
  return %references;
}

sub query {
  my %constraints = (shift, shift);
  my %references = @_;
  my %results = ();
  foreach my $k (sort keys %references) {
    my $entry = $references{$k};
    if (all { $entry->get($_) && $entry->get($_) eq $constraints{$_} } keys %constraints) {
      $results{$entry->key} = $entry;
    }
  }
  return %results;
}

sub count_mentions_by_type {
  my $type = shift;
  my %references = @_;
  my $count = 0;
  foreach (keys %references) {
    if ($references{$_}{mention_type} && $references{$_}{mention_type} eq $type) {
      $count++;
    }
  }
  return $count;
}

sub count_software_mentioned_by_type {
  my $type = shift;
  my %dataset = @_;
  my @software_mentioned = ();
  foreach my $k (keys %dataset) {
    foreach (keys %{ $dataset{$k}{references} }) {
      if ($dataset{$k}{references}{$_}{mention_type} && $dataset{$k}{references}{$_}{mention_type} eq $type) {
        push @software_mentioned, $k;
      }
    }
  }
  return scalar uniq @software_mentioned;
}

sub count_software_mentioned_by_type_and_conf {
  my $type = shift;
  my $conference = shift;
  my %dataset = @_;
  my @software_mentioned = ();
  foreach my $k (grep { $dataset{$_}{conference} eq $conference } keys %dataset) {
    foreach (keys %{ $dataset{$k}{references} }) {
      if ($dataset{$k}{references}{$_}{mention_type} && $dataset{$k}{references}{$_}{mention_type} eq $type) {
        push @software_mentioned, $k;
      }
    }
  }
  return scalar uniq @software_mentioned;
}

sub find_references {
  my %bib = %{ $_[0] };
  my %references = %{ $_[1] };
  my @ids = ();
  foreach my $b (keys %bib) {
    foreach my $r (keys %references) {
      if ($bib{$b}{title} && lc($references{$r}->get('title')) eq lc($bib{$b}{title})) {
        push @ids, $references{$r}->get('id');
      }
      elsif ($bib{$b}{doi} && $references{$r}->get('doi') eq $bib{$b}{doi}) {
        push @ids, $references{$r}->get('id');
      }
    }
  }
  return uniq @ids;
}

sub metrics_load {
  my $file = shift;
  my ($global, @files) = LoadFile $file;
  my $stat = Statistics::Descriptive::Full->new();
  $stat->add_data(map { $_->{sc} } @files);
  return {
    sc_mean          => $global->{sc_mean} // 0,
    sc_percentile_75 => $stat->percentile(75) // 0,
    sc_percentile_90 => $stat->percentile(90) // 0,
    sc_percentile_95 => $stat->percentile(95) // 0,
    sc_lanza_low     => ($stat->mean - $stat->standard_deviation) // 0,
    sc_lanza_medium  => $stat->mean // 0,
    sc_lanza_high    => ($stat->mean + $stat->standard_deviation) // 0,
    total_modules    => $global->{total_modules} // 0,
    total_eloc       => $global->{total_eloc} // 0,
  };
}

sub years_mentioned {
  my $k = $_[0];
  my %dataset = %{ $_[1] };
  my %references = %{ $_[2] };
  my @years = ();
  foreach my $r (grep { $dataset{$k}{references}{$_}{is_software_mentioned} eq 'yes' } keys %{ $dataset{$k}{references} }) {
    push @years, $references{$r}->get('year');
  }
  return uniq sort @years;
}

sub count_total {
  my $file = shift;
  open my $FILE, '<', $file;
  local $/ = undef;
  my $content = <$FILE>;
  close $FILE;
  $content =~ m/PAPERS TOTAL = (\d+)/ ? $1 : 0;
}

sub count_included {
  my $file = shift;
  open my $FILE, '<', $file;
  local $/ = undef;
  my $content = <$FILE>;
  close $FILE;
  $content =~ m/INCLUDED = (\d+)/ ? $1 : 0;
}

sub sort_ids {
  my %dataset = @_;
  sort { substr($a, 1) <=> substr($b, 1) } keys %dataset;
}

return 1;
