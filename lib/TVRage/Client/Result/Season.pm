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
    my $season_number = $self->data->{no};
    return $season_number =~ s/0*(\d+)/$1/;
}

has 'episodes' => (
    is      => 'ro',
    lazy    => 1,
    builder => '_build_episodes',
);

sub _build_episodes {
    my ($self) = @_;
    return TVRage::Client::ResultSet::Episode->new( { data => $self->data->{episode} , season => $self} );
}

__PACKAGE__->meta->make_immutable;

1;

