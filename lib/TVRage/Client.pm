package TVRage::Client;

use Moose;
use TVRage::Client::Result::Serie;
use TVRage::Client::ResultSet::Serie;
use TVRage::Client::Result::Season;
use TVRage::Client::Result::Episode;
use XML::Hash;
use Try::Tiny;
use Encode qw(decode encode);

our $VERSION = '0.01';



has 'base_url'  => (
    is       => 'ro',
    isa      => 'Str',
    default  => 'http://services.tvrage.com',
);
   
has 'coder' => (
    is => 'ro',
    isa => 'XML::Hash',
    lazy => 1,
    builder => '_build_coder'
);


sub _build_coder {
    my $self = shift;
    return XML::Hash->new();
};

with 'TVRage::Client::Meta::HTTPClient';

=head2 search

Performs a search against

=cut

sub all_series {
    my ($self, $id) = @_;
    #my $url = $self->base_url.'/show_list.php';
    my $url = $self->base_url.'/recaps/last_recaps.php?days=100';
    my $result = $self->fetch_result($url);
    return TVRage::Client::ResultSet::Serie->new({ data => $result->{recaps}, client => $self });
}

sub series_with_id {
    my ( $self, $id ) = @_;
    try {
        return TVRage::Client::Result::Serie->new({ id => $id, client => $self });
    } catch {
        return undef;
    };
}

sub full_series_data {
    my ($self, $id) = @_;
    my $url = $self->base_url."/feeds/full_show_info.php?sid=$id";
    return $self->fetch_result($url);
}

sub search_imdb {
    my ($self, $title) = @_;
    my $url = 'http://www.omdbapi.com/?r=xml&t='.$title;
    return $self->fetch_result($url);
}
sub fetch_result {
    my ($self, $url) = @_;
    my $uri = URI->new($url);
    my $content = encode('utf8', $self->fetch($uri));
    my $result = $self->coder->fromXMLStringtoHash($content);
    return $result;
}

__PACKAGE__->meta->make_immutable;

1;
