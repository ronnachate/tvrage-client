package TVRage::Client::Meta::Query;

=head1 NAME

TVRage::Client::Meta::Query

=head1 DESCRIPTION

Interface for every query

=cut

use Moose::Role;

requires 'as_uri';

has 'baseurl'  => (
    is      => 'ro',
    isa     => 'Str',
    required => 1,
);

1;
