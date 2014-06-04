package TVRage::Client::Result::Episode;

use Moose;
use Date::Parse;
use Clone qw(clone);



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

sub published {
    my ($self) = @_;
    return str2time($self->data->{airdate});
}

__PACKAGE__->meta->make_immutable;

1;

