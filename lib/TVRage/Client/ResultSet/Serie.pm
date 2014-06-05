package TVRage::Client::ResultSet::Serie;

use Moose;
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
    if( $self->data ) {
    	return [ map { TVRage::Client::Result::Serie->new( { id => $_->{id} , client => $self->client} ) }  @{$self->data->{shows}->{show}} ];
    }
}

sub first {
	my $self = shift;
	return $self->items->[0];
}

1;
