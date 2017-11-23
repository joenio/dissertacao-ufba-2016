package Dissertacao;
use strict;
use Exporter 'import';
use Text::BibTeX ':subs';
use List::Util qw( all uniq );
use YAML qw( LoadFile );
use Statistics::Descriptive;
use vars qw(@EXPORT_OK);

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
);

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

return 1;
