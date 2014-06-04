package TVRage::Client;

use Moose;
use TVRage::Client::Result::Serie;
use TVRage::Client::Result::Season;
use TVRage::Client::Result::Episode;
use XML::Hash;

our $VERSION = '0.01';
   
   
   
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
    my $file = $self->data_dir."/$id.json";
    if (!-e $file) { 
    	return;
    }
    my $content = read_file($file);
    my $result = $self->json_coder->utf8->decode($content);
    return TVRage::Client::Result::Serie->new({ data => $result });
}

sub serie_with_id {
    my ($self, $id) = @_;
    my $file = $self->data_dir."/$id.json";
    if (!-e $file) { 
    	return;
    }
    my $content = read_file($file);
    my $result = $self->json_coder->utf8->decode($content);
    return TVRage::Client::Result::Serie->new({ data => $result });
}


sub fetch_result {
    my ($self, $url) = @_;
    my $uri = URI->new($url);
    my $content = $self->fetch($uri);
    my $result = $self->xml_coder->fromXMLStringtoHash($content);
    return $result;
}

__PACKAGE__->meta->make_immutable;

1;
