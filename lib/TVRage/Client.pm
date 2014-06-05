package TVRage::Client;

use Moose;
use TVRage::Client::Result::Serie;
use TVRage::Client::ResultSet::Serie;
use TVRage::Client::Result::Season;
use TVRage::Client::Result::Episode;
use XML::Hash;
use Encode qw(decode encode);

our $VERSION = '0.01';



has 'base_url'  => (
    is       => 'ro',
    isa      => 'Str',
    default  => 'http://services.tvrage.com/feeds',
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

sub all_series{
    my ($self, $id) = @_;
    my $url = $self->base_url.'/show_list.php';
    my $result = $self->fetch_result($url);
    return TVRage::Client::ResultSet::Serie->new({ data => $result, client => $self });
}

sub series_with_id{
    my ( $self, $id ) = @_;
    return TVRage::Client::Result::Serie->new({ id => $id, client => $self });
}

sub full_series_data {
    my ($self, $id) = @_;
    my $url = $self->base_url."/full_show_info.php?sid=$id";
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
