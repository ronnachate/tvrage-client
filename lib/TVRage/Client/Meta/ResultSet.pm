package TVRage::Client::Meta::ResultSet;

use Moose::Role;
use MooseX::Iterator;
use namespace::autoclean;

=head1 NAME

TVRage::Client::Meta::ResultSet

=head1 DESCRIPTION

ResultSet role

=cut


has 'data' => (
    is       => 'ro',
    isa      => 'Any',
    required => 1,
);

has 'iterator' => (
    is      => 'ro',
    isa     => 'MooseX::Iterator::Array',
    lazy    => 1,
    builder => '_build_iterator',
    handles => [ qw/has_next next reset/ ],
);

requires 'items';

=head1 METHODS

=head2 iterator

Returns an iterator that will iterate through _all_ items matching the current filters,

=cut

sub _build_iterator {
    my ($self) = @_;
    return MooseX::Iterator::Array->new( collection => $self->items );
}

=head2 has_next

Return true if there is a next item in this resultset, false if not.

=cut

=head2 next

Returns the next item in this resultset.

=cut

=head2 reset

Resets the cursor so C<next> will start from the beginning again.

=cut

=head2 first

Returns the first item in this resultset.

=cut

sub first {
    my $self = shift;
    return $self->items->[0];
}

=head2 count

Returns the number of items in this resultset.

=cut

sub count {
    my $self = shift;
    return scalar @{$self->items};
}

1;
