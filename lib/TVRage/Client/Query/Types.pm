package MeeTV::WS::ClientX::Query::Types;

use namespace::autoclean;
use MooseX::Types -declare => [ qw/ Category Limit Ordering Options / ];
use MooseX::Types::Moose qw/Str/;

my $allowed_order = join '|', qw(
    alphabetical
    genre
    latest
    popularity
);

subtype Ordering,
    as Str,
    where { $_ =~ qr/($allowed_order)$/x };

subtype Limit,
    as Str,
    where { $_ > 0 };
    
subtype Category,
    as Str;

subtype Options,
    as Str;

__PACKAGE__->meta->make_immutable;

1;
