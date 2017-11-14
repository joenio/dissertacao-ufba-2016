package Dissertacao;
use strict;
use Exporter 'import';
use Text::BibTeX ':subs';
use List::Util qw( all );
use vars qw(@EXPORT_OK);
@EXPORT_OK = qw( equal unique foreach_bibtex_entry query bibtex_load clean count_mentions_by_type ); # symbols to export on request

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

sub clean {
  my %references = @_;
  foreach my $k (sort keys %references) {
    $references{$k}->delete(
      'review',
      'really_refers_to_software',
      'contribution_weight',
      'weightless_contributions',
      'conference',
      'step',
    );
  }
  return %references;
}

sub count_mentions_by_type {
  my $type = shift;
  my %references = @_;
  my $count = 0;
  foreach (keys %references) {
    if ($references{$_}{contribution_weight} && $references{$_}{contribution_weight} == $type) {
      $count++;
    }
  }
  return $count;
}

return 1;
