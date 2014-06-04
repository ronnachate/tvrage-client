package TVRage::Client::Result::Link;

use Moose;
use namespace::autoclean;

has [ qw/rel href hreflang title type length/ ] => (is => 'ro');

__PACKAGE__->meta->make_immutable;

1;
