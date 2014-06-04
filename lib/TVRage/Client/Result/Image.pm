package TVRage::Client::Result::Image;

use Moose;
use namespace::autoclean;

has 'width' => (
    is  => 'ro',
    isa => 'Num',
);

has 'height' => (
    is  => 'ro',
    isa => 'Num',
);

has 'url' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

1;
