package TVRage::Client::ResultSet::Serie;

use Moose;
use Try::Tiny;
use List::MoreUtils qw( uniq );
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
    	my @ids =();
        for my $serie (@{$self->data->{show}}) {
        	push( @ids, $serie->{id}->{text});
        }
        @ids = uniq(@ids);
        try {
                return [ map { TVRage::Client::Result::Serie->new( { id=> $_ , client => $self->client } ) }  @ids ];
        } catch {
                warn "caught error: data error"; # not $@
        };
    }
    return [];
}

sub first {
	my $self = shift;
	return $self->items->[0];
}

1;
