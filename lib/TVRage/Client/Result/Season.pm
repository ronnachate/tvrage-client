package TVRage::Client::Result::Season;

use Moose;
use namespace::autoclean;
use TVRage::Client::ResultSet::Episode;


has 'data' => (
    is       => 'ro',
    isa      => 'HashRef',
    required => 1,
);

has 'number' => (
    is       => 'ro',
    isa      => 'Int',
    lazy     => 1,
    builder  =>  '_build_number',
);

has 'titles' => (
    is       => 'ro',
    isa      => 'HashRef',
    lazy     => 1,
    builder  =>  '_build_titles',
);

has 'descriptions' => (
    is       => 'ro',
    isa      => 'HashRef',
    lazy     => 1,
    builder  =>  '_build_descriptions',
);

has 'episodes' => (
    is => 'ro',
    isa => 'TVRage::Client::ResultSet::Episode',
    lazy => 1,
    builder => '_build_episodes',
);

sub _build_episodes{
    my ($self) = @_;
    return TVRage::Client::ResultSet::Episode->new( data => $self->data->{episodes});
}

sub _build_number {
    my ($self) = @_;
    return $self->data->{number};
}

sub _build_titles {
    my ($self) = @_;
    my $titles = {};
    foreach my $title ( @{$self->data->{titles}} ) {
    	if( $title->{locale} ) {
    		$titles->{$title->{locale}} = $title->{title};
    	}
    	else {
    		$titles->{default} = $title->{title};
    	}
    }
    return $titles;
}

sub _build_descriptions {
    my ($self) = @_;
    return $self->data->{descriptions};
}


__PACKAGE__->meta->make_immutable;

1;

