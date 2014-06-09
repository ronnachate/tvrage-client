package TVRage::Client::ResultSet::Season;

use Moose;
use TVRage::Client::Result::Season;
=head1 NAME

TVRage::Client::ResultSet::Series

=head1 DESCRIPTION

Resultset class for series objects

=cut

with 'TVRage::Client::Meta::ResultSet';

has 'serie' => (
    is       => 'ro',
    isa      => 'TVRage::Client::Result::Serie',
    required => 1,
);

=head1 METHODS


=head2 _build_items

Returns an ArrayRef with Result objects.

=cut

sub items {
    my $self = shift;
    if( $self->data ) {
        if( ref $self->data->{Season} eq 'HASH' ) {
            return [ TVRage::Client::Result::Season->new( { data => $self->data->{Season} , serie => $self->serie } ) ];
        }
        elsif ( ref $self->data->{Season} eq 'ARRAY' ) {
            return [ map { TVRage::Client::Result::Season->new( { data => $_ , serie => $self->serie } ) }  @{$self->data->{Season}} ];
        }   	
    }
}

sub first {
	my $self = shift;
	return $self->items->[0];
}

1;
