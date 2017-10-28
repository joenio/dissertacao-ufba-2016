package Dissertacao;
use Exporter 'import';
use vars qw(@EXPORT_OK);
@EXPORT_OK = qw(equal); # symbols to export on request

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

return 1;
