package TVRage::Client::ResultSet::Season;

use Moose;
use TVRage::Client::Result::Season;
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

sub items {
    my $self = shift;
    if( $self->data ) {
    	return [ map { TVRage::Client::Result::Season->new( data => $_ ) }  values %{$self->data} ];
    }
}

sub first {
	my $self = shift;
	return $self->items->[0];
}

1;
