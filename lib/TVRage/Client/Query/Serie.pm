package TVRage::Client::Query::Serie;

=head1 NAME

TVRage::Client::Query::Asset

=head1 DESCRIPTION

Object wrapper around the input parameters for C<assets>

=cut

use Moose;
use MooseX::StrictConstructor;
use namespace::autoclean;
use TVRage::Client::Query::Types qw /Ordering/;

has 'id'       => ( is => 'ro', isa => 'Str' );
has 'rows'     => ( is => 'ro', isa => 'Int' );
has 'page'     => ( is => 'ro', isa => 'Int' );
has 'show_id'  => ( is => 'ro', isa => 'Str' );
has 'q'        => ( is => 'ro', isa => 'Str' );

with 'TVRage::Client::Meta::Query';

my @args = qw(
    page
    rows
);


=head1 METHODS

=head2 search_args

Returns the validated and formatted args.

=cut

sub search_args {
    my $self = shift;
    my $args = {};
    foreach my $attr (@args) {
        next if ! defined $self->$attr;
        $args->{$attr} = $self->$attr;
    }
    return $args;
}


=head2 as_uri

Returns a URI object ready to send to client.

=cut

sub as_uri {
    my $self = shift;
    my $uri;
    if ($self->id) { #asset with id
        $uri = URI->new($self->baseurl.'/assets/'.$self->id);
    }
    elsif ($self->q) {
        $uri = URI->new($self->baseurl.'/categories/'.$self->base_category.'/search/assets?text='.$self->q);
    }
    else {  #asset with in specific show
        if( $self->show_id ) {
            $uri = URI->new($self->baseurl.'/shows/'.$self->show_id.'/assetgroups');
            $uri->query_form($self->search_args());
        }
        else {
            die "No show_id params specified";
        }
    }
    return $uri;
}
__PACKAGE__->meta->make_immutable;

1;
