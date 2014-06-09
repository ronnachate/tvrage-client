package TVRage::Client::ResultSet::Episode;

use Moose;
use TVRage::Client::Result::Episode;

=head1 NAME

TVRage::Client::ResultSet::Series

=head1 DESCRIPTION

Resultset class for series objects

=cut

with 'TVRage::Client::Meta::ResultSet';

has 'season' => (
    is       => 'ro',
    isa      => 'TVRage::Client::Result::Season',
    required => 1,
);

=head1 METHODS


=head2 _build_items

Returns an ArrayRef with Result objects.

=cut

sub items {
    my $self = shift;
    if( $self->data ) {
        if( ref $self->data eq 'HASH' ) {
            return [ TVRage::Client::Result::Episode->new( { data => $self->data , season => $self->season } ) ];
        }
        elsif ( ref $self->data eq 'ARRAY' ) {
            return [ map { TVRage::Client::Result::Episode->new( { data => $_ , season => $self->season } ) }  @{$self->data} ];
        }
    	
    }
}

1;
