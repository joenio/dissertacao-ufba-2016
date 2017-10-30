package Dissertacao;
use Exporter 'import';
use vars qw(@EXPORT_OK);
@EXPORT_OK = qw( equal unique foreach_bibtex_file ); # symbols to export on request

sub equal {
  my ($a, $b) = @_;
  my $title = $a->get('title');
  my $doi = $a->get('doi') // undef;
  my $isbn = $a->get('isbn') // undef;
  if ($title && $b->get('title') && lc($b->get('title')) eq lc($title)) {
    return 1;
  }
  elsif ($doi && $b->get('doi') && $doi eq $b->get('doi')) {
    return 1;
  }
  elsif ($isbn && $b->get('isbn') && $isbn eq $b->get('isbn')) {
    return 1;
  }
  return 0;
}

sub _equal {
  my ($a, $b) = @_;
  if ($a->{title} && $b->{title} && lc($a->{title}) eq lc($b->{title})) {
    return 1;
  }
  elsif ($a{doi} && $b{doi} && $a{doi} eq $b{doi}) {
    return 1;
  }
  elsif ($a{isbn} && $b{isbn} && $a{isbn} eq $b{isbn}) {
    return 1;
  }
  return 0;
}

sub unique {
  my %references = @_;
  my %uniq = ();
  foreach my $k (sort keys %references) {
    unless (grep { _equal($references{$k}, $uniq{$_}) } keys %uniq) {
      $uniq{$k} = $references{$k};
    }
  }
  return %uniq;
}

sub foreach_bibtex_file {
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

return 1;
