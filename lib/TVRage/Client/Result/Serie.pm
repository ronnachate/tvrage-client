package TVRage::Client::Result::Serie;

use Moose;
use namespace::autoclean;
use TVRage::Client::ResultSet::Season;

has 'data' => (
    is       => 'ro',
    isa      => 'HashRef',
    required => 1,
);

#has 'seasons' => (
#    is => 'ro',
#    isa => 'TVRage::Client::ResultSet::Season',
#    lazy => 1,
#    builder => '_build_seasons',
#);

has 'titles' => (
    is       => 'ro',
    isa      => 'HashRef',
    lazy     => 1,
    builder  =>  '_build_titles',
);

#has 'descriptions' => (
#    is       => 'ro',
#    isa      => 'HashRef',
#    lazy     => 1,
#    builder  =>  '_build_descriptions',
#);

has 'id' => (
    is       => 'ro',
    isa      => 'Str',
    lazy     => 1,
    builder  =>  '_build_id',
);

sub _build_id {
    my ($self) = @_;
    return $self->data->{id};
}

sub _build_titles {
    my ($self) = @_;
#    my $titles = {};
#    foreach my $title ( @{$self->data->{titles}} ) {
#    	if( $title->{locale} ) {
#    		$titles->{$title->{locale}} = $title->{title};
#    	}
#    	else {
#    		$titles->{default} = $title->{title};
#    	}
#    }
#    return $titles;
    return $self->data->{titles};
}
#
#sub _build_descriptions {
#    my ($self) = @_;
#    return $self->data->{descriptions};
#}
#
#sub _build_seasons{
#    my ($self) = @_;
#    return TVRage::Client::ResultSet::Season->new( data => $self->data->{seasons});
#}
#
#sub season_with_number {
#	my ($self) = @_;
#	
#}
#
#
#sub ratings {
#	my ($self) = @_;
#	return $self->data->{ratings};
#}

__PACKAGE__->meta->make_immutable;

1;

