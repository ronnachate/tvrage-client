package TVRage::Client::Meta::Urlify;

use Moose::Role;
use Text::Unaccent;
use utf8;

=head2 urlify

Returns an url safe string

=cut

sub urlify {
    my ($self_or_class, $term) = @_;
    $term =~ tr/æÆ\//aa-/;
    $term = lc(unac_string('UTF-8', $term));
    $term =~ s/[^a-z0-9A-Z]/-/g;
    $term =~ s/[ -]+/-/g;
    $term =~ s/-+$//;
    return $term;
}

1;