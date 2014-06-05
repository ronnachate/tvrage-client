package TVRage::Client::Result::Season;

use Moose;
use TVRage::Client::ResultSet::Episode;
use TVRage::Client::Result::Serie;
use namespace::autoclean;


has 'data' => (
    is       => 'ro',
    isa      => 'HashRef',
);

has 'number' => (
    is       => 'ro',
    isa      => 'Str',
    builder  => '_build_number',
);

has 'serie' => (
    is       => 'ro',
    isa      => 'TVRage::Client::Result::Serie',
    required => 1,
);

sub _build_number {
    my ($self) = @_;
    return $self->data->{no};
}

#has 'episodes' => (
#    is      => 'ro',
#    lazy    => 1,
#    builder => '_build_episodes',
#);
#
#sub _build_episodes {
#    my ($self) = @_;
#    return TVRage::Client::ResultSet::Episode->new( data => $self->data->{episode} );
#}

__PACKAGE__->meta->make_immutable;

1;

