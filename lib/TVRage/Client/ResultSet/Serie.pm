package TVRage::Client::ResultSet::Serie;

use Moose;
use Try::Tiny;
use TVRage::Client::Result::Serie;
=head1 NAME

TVRage::Client::ResultSet::Series

=head1 DESCRIPTION

Resultset class for series objects

=cut

with 'TVRage::Client::Meta::ResultSet';

=head1 METHODS


=head2 _build_items

Returns an ArrayRef with Result objects.

=cut

has 'client' => (
    is       => 'ro',
    isa      => 'TVRage::Client',
    required => 1,
);

sub items {
    my $self = shift;
    my $items = [ ];
    if( $self->data ) {
        for my $serie (@{$self->data->{show}}) {
            try {
                push(@$items,  TVRage::Client::Result::Serie->new( { id => $serie->{id}->{text} , client => $self->client} ));
            } catch {
                warn "caught error: data error for :". $serie->{id}->{text}; # not $@
            };
        }
    }
    return $items;
}

sub first {
	my $self = shift;
	return $self->items->[0];
}

1;
