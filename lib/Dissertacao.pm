package Dissertacao;
use strict;
use Exporter 'import';
use Text::BibTeX ':subs';
use List::Util qw( all uniq sum );
use YAML::XS qw( LoadFile );
use Statistics::Descriptive;
use File::Spec::Functions;
use vars qw(@EXPORT);

use constant ROOT => $ENV{PWD};

# symbols to export by default
@EXPORT = qw(
  ROOT
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
  search_count
  search_unique_count
  screening_unique_count
  count_mentions
  cite_count
  use_count
  contribute_count
  releases_available_count
  releases_years
  releases_scam_count
  releases_available_scam_count
  releases_years_scam
  mentions_closedown_count
  mentions_servicing_count
  mentions_evolution_count
  mentions_phaseout_count
  mentions_initialdevelopment_count
  mentions_closedown_scam_count
  mentions_servicing_scam_count
  mentions_evolution_scam_count
  mentions_phaseout_scam_count
  mentions_initialdevelopment_scam_count
  filter_by_conference
  filter_by_stage
  stage_percnt
);

sub stage_percnt {
  my $stage = shift;
  my %dataset = @_;
  my $total = keys %dataset;
  my $stage_count = grep { $dataset{$_}{life_cycle}{stage} eq $stage } keys %dataset;
  sprintf("%.2f", $stage_count * 100 / $total);
}

sub search_unique_scam_count {
  my %dataset = @_;
  scalar uniq map { keys %{ $dataset{$_}{references} } } grep { $dataset{$_}{conference} eq 'SCAM' } keys %dataset
}

sub filter_by_stage {
  my $stage = shift;
  my %dataset = @_;
  foreach (keys %dataset) {
    delete $dataset{$_} if $dataset{$_}{life_cycle}{stage} ne $stage;
  }
  return %dataset;
}

sub filter_by_conference {
  my $conference = shift;
  my %dataset = @_;
  foreach (keys %dataset) {
    delete $dataset{$_} if $dataset{$_}{conference} ne $conference;
  }
  return %dataset;
}

sub count_mentions {
  my %dataset = @_;
  my $count = 0;
  foreach my $k (keys %dataset) {
    foreach my $id (keys %{ $dataset{$k}{references} }) {
      if ($dataset{$k}{references}{$id}{mention_type}) {
        $count++;
      }
    }
  }
  return $count;
}

sub mentions_closedown_count {
  count_mentions filter_by_stage('Closedown', @_);
}

sub mentions_servicing_count {
  count_mentions filter_by_stage('Servicing', @_);
}

sub mentions_evolution_count {
  count_mentions filter_by_stage('Evolution', @_);
}

sub mentions_phaseout_count {
  count_mentions filter_by_stage('Phaseout', @_);
}

sub mentions_closedown_scam_count {
  count_mentions filter_by_stage('Closedown', filter_by_conference('SCAM', @_));
}

sub mentions_servicing_scam_count {
  count_mentions filter_by_stage('Servicing', filter_by_conference('SCAM', @_));
}

sub mentions_evolution_scam_count {
  count_mentions filter_by_stage('Evolution', filter_by_conference('SCAM', @_));
}

sub mentions_phaseout_scam_count {
  count_mentions filter_by_stage('Phaseout', filter_by_conference('SCAM', @_));
}

sub mentions_initialdevelopment_scam_count {
  count_mentions filter_by_stage('Initial development', filter_by_conference('SCAM', @_));
}

sub mentions_initialdevelopment_count {
  count_mentions filter_by_stage('Initial development', @_);
}

sub releases_scam_count {
  my %dataset = filter_by_conference('SCAM', @_);
  sum map { scalar @{ $dataset{$_}{releases}{versions} } } keys %dataset;
}

sub releases_years_scam {
  my %dataset = filter_by_conference('SCAM', @_);
  my @years = ();
  foreach my $k (keys %dataset) {
    push @years, map { $_->{released_at} =~ /^(\d{4})/ ? $1 : undef } @{ $dataset{$k}{releases}{versions} };
  }
  uniq sort grep { $_ } @years;
}

sub releases_years {
  my %dataset = @_;
  my @years = ();
  foreach my $k (keys %dataset) {
    push @years, map { $_->{released_at} =~ /^(\d{4})/ ? $1 : undef } @{ $dataset{$k}{releases}{versions} };
  }
  uniq sort grep { $_ } @years;
}

sub releases_available_scam_count {
  my %dataset = filter_by_conference('SCAM', @_);
  my $count = 0;
  foreach my $k (keys %dataset) {
    if ($dataset{$k}{features}{source_code} ne 'undefined') {
      $count += grep { $_->{source} !~ m/unavailable|unknown/ } @{ $dataset{$k}{releases}{versions} };
    }
  }
  return $count;
}

sub releases_available_count {
  my %dataset = @_;
  my $count = 0;
  foreach my $k (keys %dataset) {
    if ($dataset{$k}{features}{source_code} ne 'undefined') {
      $count += grep { $_->{source} !~ m/unavailable|unknown/ } @{ $dataset{$k}{releases}{versions} };
    }
  }
  return $count;
}

sub cite_count {
  my %dataset = @_;
  sum map { count_mentions_by_type('cite', %{ $dataset{$_}{references} }) } keys %dataset;
}

sub use_count {
  my %dataset = @_;
  sum map { count_mentions_by_type('use', %{ $dataset{$_}{references} }) } keys %dataset;
}

sub contribute_count {
  my %dataset = @_;
  sum map { count_mentions_by_type('contribute', %{ $dataset{$_}{references} }) } keys %dataset;
}

sub search_count {
  my %dataset = @_;
  sum map { $dataset{$_}{search}{acm}{results} + $dataset{$_}{search}{ieee}{results} } keys %dataset;
}

sub search_unique_count {
  my %dataset = @_;
  ## scalar keys %references
  scalar uniq map { keys %{ $dataset{$_}{references} } } keys %dataset;
}

sub screening_unique_count {
  my %dataset = @_;
  my @mentions = ();
  foreach my $k (keys %dataset) {
    foreach my $id (keys %{ $dataset{$k}{references} }) {
      if ($dataset{$k}{references}{$id}{is_software_mentioned} eq 'yes') {
        push @mentions, $id;
      }
    }
  }
  scalar uniq @mentions;
}

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
